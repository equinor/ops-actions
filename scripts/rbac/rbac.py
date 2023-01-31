import os
import yaml

from azure.identity import DefaultAzureCredential
from azure.mgmt.authorization import AuthorizationManagementClient

def read_config():
  config_file = open("rbac.yml", "r")
  config = yaml.load(config_file, Loader=yaml.SafeLoader)
  role_assignments = config["roleAssignments"]
  return role_assignments

def get_azure_role_assignments(authorization_client):
  role_assignments = authorization_client.role_assignments.list_for_subscription(filter=None)
  return role_assignments

def main():
  credential = DefaultAzureCredential()
  subscription_id = os.environ.get("AZURE_SUBSCRIPTION_ID") # TODO: check if envvar is empty
  authorization_client = AuthorizationManagementClient(credential=credential, subscription_id=subscription_id)

  config_role_assignments = read_config()
  print(config_role_assignments)

  azure_role_assignments = get_azure_role_assignments(authorization_client)
  print(*azure_role_assignments)

if __name__ == "__main__":
  main()
