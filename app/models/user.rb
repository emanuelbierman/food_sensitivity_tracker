class User < ActiveRecord::Base
  has_secure_password
  has_many :days
  has_many :foods, through: :days
  has_many :symptoms, through: :days
  validates_presence_of :username, :password

end
