import os
import re
import yaml

from azure.identity import DefaultAzureCredential
from azure.mgmt.authorization import AuthorizationManagementClient

def read_config():
  config_file = open("rbac.yml", "r")
  config = yaml.safe_load(config_file)
  role_assignments = config["roleAssignments"]
  return role_assignments

def get_azure_role_assignments(authorization_client):

  def is_subscription_scope(role_assignment):
    # Returns true if the role assignment is scoped at the subscription or lower
    scope = getattr(role_assignment, "scope")
    x = re.search("^/subscriptions/*", scope)
    return x

  role_assignments = authorization_client.role_assignments.list_for_subscription()
  filtered = filter(is_subscription_scope, role_assignments)
  return filtered

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
