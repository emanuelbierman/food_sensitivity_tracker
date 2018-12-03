class Food < ActiveRecord::Base
  has_and_belongs_to_many :days
  has_many :symptoms, through: :days
  validates_presence_of :name, :serving

end
