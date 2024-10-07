import asyncio

from azure.identity.aio import DefaultAzureCredential
from msgraph import GraphServiceClient

user_id = ""  # TODO: set user principal name here


async def get_user():
    user = await client.users.by_user_id(user_id).get()
    if user:
        print(user.display_name)


credentials = DefaultAzureCredential()
scopes = ["https://graph.microsoft.com/.default"]
client = GraphServiceClient(credentials=credentials, scopes=scopes)
asyncio.run(get_user())
