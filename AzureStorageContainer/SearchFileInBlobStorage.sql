create database scoped credential [AzureStorageCredential]
with
    identity = 'SHARED ACCESS SIGNATURE',
    secret = '<sasTokenWithoutLeadingQuestionMark>';
go

create external data source [AzureStorageConainer]
with (
    location = 'abs://<account>.blob.core.windows.net/<container>',
    credential = [AzureStorageCredential]
);
go

select
    [C].filename()          as [FileName],
    [C].[FileContent]       as [FileContent]
from openrowset(
    bulk '*',
    data_source = 'AzureStorageConainer',
    format = 'csv',
    fieldterminator ='0x0b',
    fieldquote = '0x0b'
) with ([FileContent] nvarchar(max)) as [C];