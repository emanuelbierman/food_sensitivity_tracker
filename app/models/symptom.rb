class Symptom < ActiveRecord::Base
  has_many :days_symptom
  has_many :days, through: :days_symptom, source: :day
  has_many :foods, through: :day
  validates_presence_of :description

  after_commit :update_days_count, on: [:create, :update]

  def update_days_count
    self.days_count = self.days.count
  end

  def self.symptoms_by_days_count(user_id)
    symptoms = self.joins(:days).where(days: { user_id: user_id})
    symptoms.group(:description).order(:id, days_count: :desc)
  end
end
