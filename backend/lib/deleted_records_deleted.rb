module ArchivesSpace

  class DeletedRecordsDeleter

    SCHEDULE = "* * * * *".freeze

    def self.delete(redundant_ts = nil)
      deleted_count = 0
      redundant_ts  = redundant_ts ? redundant_ts : get_redundant_ts
      DB.open do |db|
        redundant     = db[:deleted_records].where{ timestamp < redundant_ts }
        deleted_count = redundant.count
        redundant.delete if deleted_count > 0
      end
      deleted_count
    end

    def self.get_redundant_ts
      # TODO: get ts - 24hrs
      0
    end

  end

end
