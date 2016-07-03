class Home < ActiveRecord::Base
  attr_accessible :home_type

  has_many :spaces
end
