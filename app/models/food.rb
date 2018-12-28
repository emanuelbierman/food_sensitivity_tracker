class Food < ActiveRecord::Base
  has_and_belongs_to_many :days
  has_many :symptoms, through: :days
  validates_presence_of :name, :serving

  after_commit :update_days_count, on: [:create, :update]

  def update_days_count
    self.days_count = self.days.count
  end

end
