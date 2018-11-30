class Day < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :foods
  has_and_belongs_to_many :symptoms

  def month_day_year
	   self.created_at.strftime("%m-%d-%y")
  end

  def day_of_week
	   self.created_at.strftime("%A")
  end

  def previous_day
    Day.find_by(id: (self.id - 1)) || nil
  end

  def two_days_ago
    Day.find_by(id: (self.id - 2)) || nil
  end
end
