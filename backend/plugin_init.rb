require_relative 'lib/deleted_records_deleted'

ArchivesSpaceService.loaded_hook do
  ArchivesSpaceService.settings.scheduler.cron(
    # ArchivesSpace::DeletedRecordsDeleter.schedule("* * * * *"),
    ArchivesSpace::DeletedRecordsDeleter.schedule,
    :tags => 'deleted_records_deleted'
  ) do
    Log.info("Deleting (redundant) deleted records")
    # deleted_count = ArchivesSpace::DeletedRecordsDeleter.delete(0)
    deleted_count = ArchivesSpace::DeletedRecordsDeleter.delete
    Log.info("Deleted records deleted: #{deleted_count}")
  end
end
