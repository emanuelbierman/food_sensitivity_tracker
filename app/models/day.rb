class Day < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :foods
  has_and_belongs_to_many :symptoms
  validates_presence_of :user_id, :month_day_year
  # validates_uniqueness_of :date, scope: :user_id
  accepts_nested_attributes_for :foods, :symptoms

  def foods_attributes=(food_attributes)
    food = Food.where(name: food_attributes[:name]).first_or_create do |food|
      food.serving = food_attributes[:serving]
    end
    self.foods << food
  end

  def symptoms_attributes=(symptom_attributes)
    symptom = Symptom.where(name: symptom_attributes[:description]).first_or_create do |food|
      symptom.serving = symptom_attributes[:frequency]
    end
    self.symptoms << symptom
  end

  after_find do |day|
    day.set_date if day.date.nil?
    day.set_month if day.month.nil?
    day.set_day_of_week if day.day_of_week.nil?
  end

  after_commit do |day|
    day.set_date if day.date.nil?
    day.set_month if day.month.nil?
    day.set_day_of_week if day.day_of_week.nil?
  end

  def set_date
    self.date = self.created_at.strftime("%d").to_i
  end

  def set_month
    self.month = self.created_at.strftime("%m").to_i
  end

  def set_day_of_week
    self.day_of_week = self.created_at.strftime("%A")
  end

  @@thirty_days = [4, 6, 9, 11]
  @@thirty_one_days = [1, 3, 5, 7, 8, 10, 12]
  @@twenty_eight_days = [2]

  def previous_m
    if self.month > 1
      self.month - 1
    elsif self.month = 1
      12
    end
  end

  def previous_day
    if self.date > 1
      Day.find_by(date: (self.date - 1), user_id: self.user_id)
    elsif self.date = 1 && @@thirty_days.include?(self.previous_m)
      Day.find_by(date: 30, user_id: self.user_id)
    elsif self.date = 1 && @@thirty_one_days.include?(self.previous_m)
      Day.find_by(date: 31, user_id: self.user_id)
    elsif self.date = 1
      Day.find_by(date: 28, user_id: self.user_id)
    end
  end

  def two_days_ago
    if self.date > 2
      Day.find_by(date: (self.date - 2), user_id: self.user_id)
    elsif self.date = 2 && @@thirty_days.include?(self.previous_m)
      Day.find_by(date: (29), user_id: self.user_id)
    elsif self.date = 2 && @@thirty_one_days.include?(self.previous_m)
      Day.find_by(date: (30), user_id: self.user_id)
    elsif self.date = 1 && @@thirty_days.include?(self.previous_m)
      Day.find_by(date: (30), user_id: self.user_id)
    elsif self.date = 1 && @@thirty_one_days.include?(self.previous_m)
      Day.find_by(date: (31), user_id: self.user_id)
    elsif self.date = 1
      Day.find_by(date: (28), user_id: self.user_id)
    end
  end

  def next_day
    if self.date < 28
      Day.find_by(date: (self.date + 1), user_id: self.user_id)
    elsif self.date = 28 && @@twenty_eight_days.include?(self.m)
      Day.find_by(date: (30), user_id: self.user_id)
    elsif self.date = 28
      Day.find_by(date: (29), user_id: self.user_id)
    elsif self.date = 29
      Day.find_by(date: (30), user_id: self.user_id)
    elsif self.date = 30 && @@thirty_days.include?(self.m)
      Day.find_by(date: (1), user_id: self.user_id)
    elsif self.date = 30 && @@thirty_one_days.include?(self.m)
      Day.find_by(date: (31), user_id: self.user_id)
    elsif self.date = 31 && @@thirty_one_days.include?(self.m)
      Day.find_by(date: (1), user_id: self.user_id)
    end
  end

  def two_days_later
    if self.date < 27
      Day.find_by(date: (self.date + 2), user_id: self.user_id)
    elsif self.date = 27 && @@twenty_eight_days.include?(self.m)
      Day.find_by(date: (1), user_id: self.user_id)
    elsif self.date = 27
      Day.find_by(date: (29), user_id: self.user_id)
    elsif self.date = 28 && @@twenty_eight_days.include?(self.m)
      Day.find_by(date: (30), user_id: self.user_id)
    elsif self.date = 28
      Day.find_by(date: (29), user_id: self.user_id)
    elsif self.date = 29
      Day.find_by(date: (30), user_id: self.user_id)
    elsif self.date = 30 && @@thirty_days.include?(self.m)
      Day.find_by(date: (1), user_id: self.user_id)
    elsif self.date = 30 && @@thirty_one_days.include?(self.m)
      Day.find_by(date: (31), user_id: self.user_id)
    elsif self.date = 31 && @@thirty_one_days.include?(self.m)
      Day.find_by(date: (1), user_id: self.user_id)
    end
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

  def previous_day_day_of_week
    self.previous_day.day_of_week
  end

  def previous_day_month_day_year
    self.previous_day.month_day_year
  end

  def two_days_ago_day_of_week
    self.two_days_ago.day_of_week
  end

  def two_days_ago_month_day_year
    self.two_days_ago.month_day_year
  end

  def next_day_day_of_week
    self.next_day.day_of_week
  end

  def next_day_month_day_year
    self.next_day.month_day_year
  end

  def two_days_later_day_of_week
    self.two_days_later.day_of_week
  end

  def two_days_later_month_day_year
    self.two_days_later.month_day_year
  end
end
