"""
TODO(@hknutsen): write a module description.
"""

import asyncio
import subprocess

from azure.identity.aio import DefaultAzureCredential
from msgraph import GraphServiceClient
from github import Github
from github import Auth


def get_github_auth():
    """
    PyGithub does not have a native method for getting access token from GitHub CLI.
    Write custom method for this.
    """
    token = (
        subprocess.run("gh auth token", check=True, stdout=subprocess.PIPE)
        .stdout.decode()
        .strip()  # "gh auth token" includes a trailing newling. Strip it.
    )

    auth = Auth.Token(token)
    return auth


async def get_azure_user():
    """
    Get display name of authenticated Microsoft Azure user.
    """
    me = await client.me.get()
    if me:
        print("Microsoft Azure user display name: " + me.display_name)


def get_github_user():
    """
    Get name of authenticated GitHub user.
    """
    g_user_name = g.get_user().name
    print("GitHub user name: " + g_user_name)


# Authenticate to Microsoft Azure and print display name of authenticated user.
credentials = DefaultAzureCredential()
scopes = ["https://graph.microsoft.com/.default"]
client = GraphServiceClient(credentials=credentials, scopes=scopes)
asyncio.run(get_azure_user())

# Authenticate to GitHub and print name of authenticated user.
g_auth = get_github_auth()
g = Github(auth=g_auth)
get_github_user()
g.close()
