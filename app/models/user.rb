class User < ActiveRecord::Base
  has_secure_password
  has_many :days
  has_many :foods, through: :days
  has_many :symptoms, through: :days
  validates_presence_of :username, :password

  def food_names
    self.foods.group(:name).distinct
  end

  def symptom_descriptions
    self.symptoms.group(:description).distinct
  end

end
