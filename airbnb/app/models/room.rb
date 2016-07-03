class Room < ActiveRecord::Base
  attr_accessible :room_type

  has_many :spaces

end
