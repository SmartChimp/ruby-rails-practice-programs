class ReservedGuest < ActiveRecord::Base
  attr_accessible :calendar_date, :space_id, :guests_count

  MAX_RETRY = 3

  def self.increment_guests_count(from_date, to_date, space_id, count, max_no_of_accommodation)
    retry_count = 0
    is_incremented_successfully = true
    begin  
      transaction do
        reserved_guests_hash = ReservedGuest.where("calendar_date >= ? AND calendar_date <= ?  AND space_id = ?",from_date, to_date, space_id).map{ |val| [val.calendar_date.to_s, val] }.to_h
        (from_date..to_date).each do |val|
          if (reserved_guest = reserved_guests_hash[val.to_s]) != nil
            if (reserved_guest.guests_count = (reserved_guest.guests_count + count.to_i)) <= max_no_of_accommodation
              reserved_guest.save
            else
              is_incremented_successfully = false
              raise ActiveRecord::Rollback
            end
          else
            ReservedGuest.new(calendar_date: val, space_id: space_id, guests_count: count).save
          end
        end
      end
    rescue ActiveRecord::StaleObjectError, ActiveRecord::RecordInvalid, ActiveRecord::StatementInvalid
      return false if (retry_count += 1) > MAX_RETRY
      retry
    end
    is_incremented_successfully
  end
  
end
