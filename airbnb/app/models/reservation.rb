class Reservation < ActiveRecord::Base
  attr_accessible :from_date, :to_date, :user_id, :space_id, :space

  belongs_to :space
  belongs_to :user
  
end