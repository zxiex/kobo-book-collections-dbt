{{
    config(materialized='incremental')
}}


with new_coll as (
    select
        {{ book_folder_name(BookID) }} as ShelfName,
        BookID                         as ContentId
    from {{ source('kobo', 'books') }}
    where BookID like 'file:///%'
      and ContentType = 9
    group by BookID
    except
    select ShelfName, ContentID
    from {{ this }})
select ShelfName,
       ContentId,
       {{ utc_now() }} as DateModified, false as _isDeleted, false as _isSynced
from new_coll