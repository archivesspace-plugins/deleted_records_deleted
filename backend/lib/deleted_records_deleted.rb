module ArchivesSpace

  class DeletedRecordsDeleter

    SCHEDULE = "#{rand(0..59)} #{rand(0..6)} * * *".freeze

    # fyi: timestamp is a misnomer, it's a date
    def self.delete(before: nil)
      deleted_count = 0
      redundant_ts  = before ? before : get_redundant_ts
      Log.info "Using redundant ts: #{redundant_ts}"
      DB.open do |db|
        redundant     = db[:deleted_records].where{ timestamp < redundant_ts }
        deleted_count = redundant.count
        redundant.delete if deleted_count > 0
      end
      deleted_count
    end

    def self.get_redundant_ts
      (Time.now - (60 * 60 * 24))
    end

    def self.schedule(cron: nil)
      cron ? cron : SCHEDULE
    end

  end

end
