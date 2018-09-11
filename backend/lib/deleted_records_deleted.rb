module ArchivesSpace

  class DeletedRecordsDeleter

    SCHEDULE = "#{rand(0..59)} #{rand(0..6)} * * *".freeze

    def self.delete(since: nil)
      deleted_count = 0
      redundant_ts  = since ? since : get_redundant_ts
      DB.open do |db|
        redundant     = db[:deleted_records].where{ timestamp < redundant_ts }
        deleted_count = redundant.count
        redundant.delete if deleted_count > 0
      end
      deleted_count
    end

    def self.get_redundant_ts
      (Time.now - (60 * 60 * 24)).to_i
    end

    def self.schedule(cron: nil)
      cron ? cron : SCHEDULE
    end

  end

end
