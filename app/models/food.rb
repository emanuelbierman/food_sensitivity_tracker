class Food < ActiveRecord::Base
  has_many :days
  has_many :symptoms, through: :days
  validates_presence_of :name, :serving
end
