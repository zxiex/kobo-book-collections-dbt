-- The name of this SQL file does not need to be Shelf as the alias is defined.
-- This is just an example to show the use of alias in config.

{{
    config(
        alias='Shelf',
        materialized='incremental',
        unique_key='Id'
    )
}}


with new_shelf as (select {{ book_folder_name('BookID') }} as Name
                   from  {{ source('kobo', 'books') }}
                   where BookID like 'file:///%'
                     and ContentType = 9
                     and BookID not like '%Digital Editions%'
                   group by BookID),
     tba_shelf as (select distinct Name
                   from new_shelf
                   except
                   select Name
                   from {{ this }}),
     tba_shelf_time as (select Name,
                               {{ utc_now() }} as ModTime
                        from tba_shelf)
select ModTime   as CreationDate,
       Name      as Id,
       Name      as InternalName,
       ModTime   as LastModified,
       Name,
       'UserTag' as Type,
       false     as _IsDeleted,
       true      as _IsVisible,
       false     as _IsSynced,
       null      as _SyncTime,
       ModTime   as LastAccessed
from tba_shelf_time

{% if is_incremental() %}
-- this filter will only be applied on an incremental run
where Id not in (select Id from {{ this }})

{% endif %}
