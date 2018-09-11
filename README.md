# Deleted records deleted

Delete all redundant entries from the deleted records table.

## Why?

The deleted records table in a running ArchivesSpace system allows the indexer
to remove indexed records from Solr. However having been deleted from Solr the
entries are never removed from the database. In time these redundant records can
bloat the database, make re-indexing less efficient and in extreme cases even
crash the indexer.

## How?

With this plugin enabled deleted record entries are automatically deleted from
the table if they are older than 1 day from when the scheduled check runs (which
is plenty of time for the indexer to have done its job of deleting the record).

## License

This project is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

---
