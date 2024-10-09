"""
TODO(@hknutsen): write a module description.
"""

import subprocess
import requests

MICROSOFT_GRAPH_URL = "https://graph.microsoft.com/v1.0/"
GITHUB_API_URL = "https://api.github.com"


def get_msgraph_token():
    """
    Get Microsoft Graph token from Azure CLI.
    """
    token = (
        subprocess.run(
            "az account get-access-token --resource-type ms-graph --query accessToken --output tsv",
            shell=True,
            check=True,
            stdout=subprocess.PIPE,
        )
        .stdout.decode()
        .strip()  # "az account get-access-token" includes a trailing newling. Strip it!
    )
    return token


def list_entra_applications(token):
    """
    List Entra applications by given display name.
    """
    url = f"{MICROSOFT_GRAPH_URL}/applications"
    headers = {
        "Authorization": f"Bearer {token}",
    }
    params = {}
    applications = requests.get(
        url=url,
        headers=headers,
        params=params,
        timeout=300,
    )
    return applications.json()


def get_github_token():
    """
    Get GitHub token from GitHub CLI.
    """
    token = (
        subprocess.run("gh auth token", check=True, stdout=subprocess.PIPE)
        .stdout.decode()
        .strip()  # "gh auth token" includes a trailing newling. Strip it!
    )
    return token


def list_github_repos(org, token):
    """
    Get a given GitHub repository.
    """
    url = f"{GITHUB_API_URL}/orgs/{org}/repos"
    headers = {
        "Accept": "application/vnd.github+json",
        "Authorization": f"Bearer {token}",
        "X-GitHub-Api-Version": "2022-11-28",
    }
    params = {}
    repos = requests.get(
        url=url,
        headers=headers,
        params=params,
        timeout=300,
    )
    return repos.json()


# List Microsoft Entra applications.
msgraph_token = get_msgraph_token()
entra_applications = list_entra_applications(msgraph_token)
print(entra_applications)

# List GitHub repositories.
github_token = get_github_token()
github_repos = list_github_repos("equinor", github_token)
print(github_repos)
