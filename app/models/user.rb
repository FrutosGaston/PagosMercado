class User < ApplicationRecord
  has_many :payments

  validates_presence_of :username, :password
  validates_uniqueness_of :username
end
