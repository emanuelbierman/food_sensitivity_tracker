class Food < ActiveRecord::Base
  has_many :days
  has_many :symptoms, through: :days
  validates_presence_of :name, :serving

  def nested_array_of_each_previous_days_symptoms
    self.days.each do |day|
      day.previous_day.symptoms
    end
  end

  def nested_array_of_each_two_days_ago_symptoms
    self.days.each do |day|
      day.two_days_ago.symptoms
    end
  end
end
