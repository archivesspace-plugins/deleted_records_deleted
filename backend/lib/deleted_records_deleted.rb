module ArchivesSpace

  class DeletedRecordsDeleter

    SCHEDULE = "#{rand(0..59)} #{rand(0..6)} * * *".freeze

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
      (Time.now - 1.day).to_i
    end

    def self.schedule(schedule = nil)
      schedule ? schedule : SCHEDULE
    end

  end

end
