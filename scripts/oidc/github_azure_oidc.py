"""
TODO(@hknutsen): write a module description.
"""

import asyncio
import subprocess
import requests

from azure.identity.aio import DefaultAzureCredential
from msgraph import GraphServiceClient


GITHUB_API_URL = "https://api.github.com"


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


def get_github_repo(owner, repo, token):
    """
    Get a given GitHub repository.
    """
    url = f"{GITHUB_API_URL}/repos/{owner}/{repo}"
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


async def get_azure_user():
    """
    Get display name of authenticated Microsoft Azure user.
    """
    me = await azure_client.me.get()
    if me:
        print("Microsoft Azure user display name: " + me.display_name)


# Authenticate to Microsoft Azure and print display name of authenticated user.
azure_credentials = DefaultAzureCredential()
azure_scopes = ["https://graph.microsoft.com/.default"]
azure_client = GraphServiceClient(credentials=azure_credentials, scopes=azure_scopes)
asyncio.run(get_azure_user())

# Get a GitHub repository.
github_token = get_github_token()
github_repo = get_github_repo("equinor", "ops-actions", github_token)
print(github_repo["name"])
