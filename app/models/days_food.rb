class DaysFood < ActiveRecord::Base
  belongs_to :day
  belongs_to :food

  # accepts_nested_attributes_for :foods

  # def foods_attributes=(food_attributes)
  #   food = Food.where(name: food_attributes[:name]).first_or_create do |food|
  #     food.serving = food_attributes[:serving]
  #   end
  #   self.foods << food
  # end
end
