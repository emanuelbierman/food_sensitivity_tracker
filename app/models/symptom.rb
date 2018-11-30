class Symptom < ActiveRecord::Base
  has_many :days
  has_many :foods, through: :days
  validates_presence_of :type, :frequency
end
