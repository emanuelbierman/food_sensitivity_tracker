class Symptom < ActiveRecord::Base
  has_many :days_symptom
  has_many :days, through: :days_symptom, source: :day
  has_many :foods, through: :day
  validates_presence_of :description, :frequency

  # def nested_array_of_each_previous_days_foods
  #   self.days.each do |day|
  #     self.day.previous_day.foods
  #   end
  # end
  #
  # def nested_array_of_each_two_days_ago_foods
  #   self.days.each do |day|
  #     self.day.two_days_ago.foods
  #   end
  # end
end
