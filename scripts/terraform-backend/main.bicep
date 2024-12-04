@description('The name of the Storage account to create.')
param storageAccountName string

@description('The location to create the resources in.')
param location string = resourceGroup().location

@description('The name of the container to create.')
param containerName string = 'tfstate'

@description('An array of IP addresses or IP ranges that should be allowed to bypass the firewall of the Terraform backend. If empty, the firewall will be disabled.')
param ipRules array = []

@description('An array of object IDs of user, group or service principals that should have access to the Terraform backend.')
param principalIds array = []

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_GRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    supportsHttpsTrafficOnly: true
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: false
    allowCrossTenantReplication: false
    networkAcls: {
      defaultAction: length(ipRules) == 0 ? 'Allow' : 'Deny'
      virtualNetworkRules: []
      ipRules: [
        for ipRule in ipRules: {
          value: ipRule
          action: 'Allow'
        }
      ]
    }
  }

  resource blobService 'blobServices' = {
    name: 'default'
    properties: {
      deleteRetentionPolicy: {
        allowPermanentDelete: false
        enabled: true
        days: 30
      }
      containerDeleteRetentionPolicy: {
        enabled: true
        days: 30
      }
      isVersioningEnabled: true
      changeFeed: {
        enabled: true
      }
    }

    resource container 'containers' = {
      name: containerName
    }
  }

  resource managementPolicy 'managementPolicies' = {
    name: 'default'
    properties: {
      policy: {
        rules: [
          {
            name: 'Delete old tfstate versions'
            enabled: true
            type: 'Lifecycle'
            definition: {
              actions: {
                version: {
                  delete: {
                    daysAfterCreationGreaterThan: 30
                  }
                }
              }
              filters: {
                blobTypes: [
                  'blockBlob'
                ]
              }
            }
          }
        ]
      }
    }
  }
}

var roleDefinitionId = 'b7e6dc6d-f1e8-4753-8033-0f276bb0955b' // Storage Blob Data Owner

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = [
  for principalId in principalIds: {
    name: guid(principalId, roleDefinitionId)
    scope: storageAccount
    properties: {
      principalId: principalId
      roleDefinitionId: roleDefinitionId
    }
  }
]

resource lock 'Microsoft.Authorization/locks@2020-05-01' = {
  name: 'Terraform'
  scope: storageAccount
  dependsOn: [storageAccount::blobService, storageAccount::managementPolicy, roleAssignment] // Lock must be created last
  properties: {
    level: 'ReadOnly'
    notes: 'Prevent changes to Terraform backend configuration'
  }
}
