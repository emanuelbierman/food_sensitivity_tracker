class Day < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :foods
  has_and_belongs_to_many :symptoms
  validates_presence_of :user_id

  after_create do |day|
    day.set_month_day_year if day.month_day_year.nil?
    day.set_day_of_week if day.day_of_week.nil?
    day.set_date if day.date.nil?
  end

  def set_date(d = self.created_at.strftime("%d"))
    if self.date.nil?
      self.date = d.to_i
    end
  end

  def set_month_day_year(m_d_y = self.created_at.strftime("%m-%d-%y"))
    if self.month_day_year.nil?
      self.month_day_year = m_d_y
    end
  end

  def set_day_of_week(d_o_w = self.created_at.strftime("%A"))
    if self.day_of_week.nil?
      self.day_of_week = d_o_w
    end
  end

  def m
    self.month_day_year.split("-")[0].to_i
  end

  def previous_m
    if self.m > 1
      self.m - 1
    elsif self.m = 1
      12
    end
  end

  @@thirty_days = [4, 6, 9, 11]
  @@thirty_one_days = [1, 3, 5, 7, 8, 10, 12]
  @@twenty_eight_days = [2]

  def previous_day
    if self.date > 1
      Day.find_or_create_by(date: (self.date - 1), user_id: self.user_id)
    elsif self.date = 1 && @@thirty_days.include?(self.previous_m)
      Day.find_or_create_by(date: (30), user_id: self.user_id)
    elsif self.date = 1 && @@thirty_one_days.include?(self.previous_m)
      Day.find_or_create_by(date: (31), user_id: self.user_id)
    elsif self.date = 1
      Day.find_or_create_by(date: (28), user_id: self.user_id)
    end
  end

  def two_days_ago
    if self.date > 2
      Day.find_or_create_by(date: (self.date - 2), user_id: self.user_id)
    elsif self.date = 2 && @@thirty_days.include?(self.previous_m)
      Day.find_or_create_by(date: (29), user_id: self.user_id)
    elsif self.date = 2 && @@thirty_one_days.include?(self.previous_m)
      Day.find_or_create_by(date: (30), user_id: self.user_id)
    elsif self.date = 1 && @@thirty_days.include?(self.previous_m)
      Day.find_or_create_by(date: (30), user_id: self.user_id)
    elsif self.date = 1 && @@thirty_one_days.include?(self.previous_m)
      Day.find_or_create_by(date: (31), user_id: self.user_id)
    elsif self.date = 1
      Day.find_or_create_by(date: (28), user_id: self.user_id)
    end
  end

  def next_day
    if self.date < 28
      Day.find_or_create_by(date: (self.date + 1), user_id: self.user_id)
    elsif self.date = 28 && @@twenty_eight_days.include?(self.m)
      Day.find_or_create_by(date: (30), user_id: self.user_id)
    elsif self.date = 28
      Day.find_or_create_by(date: (29), user_id: self.user_id)
    elsif self.date = 29
      Day.find_or_create_by(date: (30), user_id: self.user_id)
    elsif self.date = 30 && @@thirty_days.include?(self.m)
      Day.find_or_create_by(date: (1), user_id: self.user_id)
    elsif self.date = 30 && @@thirty_one_days.include?(self.m)
      Day.find_or_create_by(date: (31), user_id: self.user_id)
    elsif self.date = 31 && @@thirty_one_days.include?(self.m)
      Day.find_or_create_by(date: (1), user_id: self.user_id)
    end
  end

  def two_days_later
    if self.date < 27
      Day.find_or_create_by(date: (self.date + 2), user_id: self.user_id)
    elsif self.date = 27 && @@twenty_eight_days.include?(self.m)
      Day.find_or_create_by(date: (1), user_id: self.user_id)
    elsif self.date = 27
      Day.find_or_create_by(date: (29), user_id: self.user_id)
    elsif self.date = 28 && @@twenty_eight_days.include?(self.m)
      Day.find_or_create_by(date: (30), user_id: self.user_id)
    elsif self.date = 28
      Day.find_or_create_by(date: (29), user_id: self.user_id)
    elsif self.date = 29
      Day.find_or_create_by(date: (30), user_id: self.user_id)
    elsif self.date = 30 && @@thirty_days.include?(self.m)
      Day.find_or_create_by(date: (1), user_id: self.user_id)
    elsif self.date = 30 && @@thirty_one_days.include?(self.m)
      Day.find_or_create_by(date: (31), user_id: self.user_id)
    elsif self.date = 31 && @@thirty_one_days.include?(self.m)
      Day.find_or_create_by(date: (1), user_id: self.user_id)
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
end
