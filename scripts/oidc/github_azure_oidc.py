"""
TODO(@hknutsen): write a module description.
"""

import asyncio
import subprocess

from azure.identity.aio import DefaultAzureCredential
from msgraph import GraphServiceClient
from github import Github as GithubClient
from github import Auth as GithubAuth


def get_github_auth():
    """
    PyGithub does not have a native method for getting access token from GitHub CLI.
    Write custom method for this.
    """
    token = (
        subprocess.run("gh auth token", check=True, stdout=subprocess.PIPE)
        .stdout.decode()
        .strip()  # "gh auth token" includes a trailing newling. Strip it!
    )
    auth = GithubAuth.Token(token)
    return auth


async def get_azure_user():
    """
    Get display name of authenticated Microsoft Azure user.
    """
    me = await azure_client.me.get()
    if me:
        print("Microsoft Azure user display name: " + me.display_name)


def get_github_user():
    """
    Get name of authenticated GitHub user.
    """
    g_user_name = github_client.get_user().name
    print("GitHub user name: " + g_user_name)


# Authenticate to Microsoft Azure and print display name of authenticated user.
azure_credentials = DefaultAzureCredential()
azure_scopes = ["https://graph.microsoft.com/.default"]
azure_client = GraphServiceClient(credentials=azure_credentials, scopes=azure_scopes)
asyncio.run(get_azure_user())

# Authenticate to GitHub and print name of authenticated user.
github_auth = get_github_auth()
github_client = GithubClient(auth=github_auth)
get_github_user()
github_client.close()
