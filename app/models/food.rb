class Food < ActiveRecord::Base
  has_and_belongs_to_many :days
  has_many :symptoms, through: :days
  validates_presence_of :name, :serving

  after_commit :update_days_count, on: [:create, :update]

  def update_days_count
    self.days_count = self.days.count
  end

  def self.foods_by_days_count(user_id)
    foods = self.joins(:days).where(days: { user_id: user_id})

    # # for every food,
    # foods_days_users = self.all.each.days.group(:user_id).having("user_id = ?", user_id)
    # # foods_days_users.select("user_id = ?" user_id)
    # self.all.days.group(:user_id)[0].user_id
    foods.group(:name).order(:id, days_count: :desc)
  end

end
