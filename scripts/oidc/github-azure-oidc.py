import asyncio

from azure.identity.aio import DefaultAzureCredential
from msgraph import GraphServiceClient


async def me():
    me = await client.me.get()
    if me:
        print(me.display_name)


credentials = DefaultAzureCredential()
scopes = ["https://graph.microsoft.com/.default"]
client = GraphServiceClient(credentials=credentials, scopes=scopes)
asyncio.run(me())
