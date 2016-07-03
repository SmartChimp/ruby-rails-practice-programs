class User < ActiveRecord::Base
  attr_accessible :email, :firstname, :lastname, :password_diggest, :salt

  has_many :spaces
  has_many :reservations

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true
  validates :password_diggest, presence: true
  validates :email, format: /\A.+@[a-zA-Z]+.[a-zA-Z]+\z/
end
