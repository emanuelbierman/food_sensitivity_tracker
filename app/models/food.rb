class Food < ActiveRecord::Base
  has_many :days_food
  has_many :days, through: :days_food, source: :day
  has_many :symptoms, through: :day
  validates_presence_of :name

  after_commit :update_days_count, on: [:create, :update]

  def update_days_count
    self.days_count = self.days.count
  end

  def self.foods_by_days_count(user_id)
    foods = self.joins(:days).where(days: { user_id: user_id})
    foods.group(:name).order(:id, days_count: :desc)
  end
end
