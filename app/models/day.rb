class Day < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :foods
  has_and_belongs_to_many :symptoms
  validates_presence_of :user_id
  # after_find do |day|
  #   day.set_month_day_year
  # end
  after_create do |day|
    day.set_month_day_year
    day.set_day_of_week
  end

  def set_month_day_year
    self.month_day_year = self.created_at.strftime("%m-%d-%y")
  end

  def set_day_of_week
	   self.day_of_week = self.created_at.strftime("%A")
  end

  def previous_day
    Day.find_by(id: (self.id - 1))
  end

  def two_days_ago
    Day.find_by(id: (self.id - 2))
  end

  def next_day
    Day.find_by(id: (self.id + 1))
  end

  def two_days_later
    Day.find_by(id: (self.id + 2))
  end

  def previous_day_foods
    self.previous_day.foods
  end

  def two_days_ago_foods
    self.two_days_ago.foods
  end

  def next_day_symptoms
    self.next_day.symptoms
  end

  def two_days_later_symptoms
    self.two_days_later.symptoms
  end
end
