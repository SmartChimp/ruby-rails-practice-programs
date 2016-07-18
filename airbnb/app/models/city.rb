class City < ActiveRecord::Base
  attr_accessible :name

  scope :get_cities_like, lambda { 
    |val| where("name LIKE ?", "#{val}%")
  }

  has_many :spaces
  
end
