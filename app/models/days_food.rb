class DaysFood < ActiveRecord::Base
  belongs_to :day
  belongs_to :food
  validates_presence_of :serving, :day_id
  accepts_nested_attributes_for :food
  # def new(params)
  #   day = Day.find_by(id: params[:day_id].to_i)
  #   serving = params[:serving].to_i
  #   comments = params[:comments]
  #   if params[:food_id].blank?
  #     self.food = params[:food][:name]
  #     self.new(day_id: day.id.to_s, food_id: food.id, serving: serving, comments: comments)
  #   # if params[:food_id].blank?
  #   #
  #   else
  #     food = Food.find_by(id: params[:food].to_i)
  #     self.new(day_id: day.id.to_s, food_id: food.id, serving: serving, comments: comments)
  #   end
  #   self
  # end

  def food_attributes=(attributes)
    self.food = Food.find_or_create_by(name: attributes[:name].downcase)
  end

  # def self.create_food_from(params)
  #   serving = params[:foods][:serving].to_i
  #   if !params[:food_id].blank?
  #     food = Food.find_by(id: params[:food_id].to_i)
  #     Food.create(name: food.name, serving: serving)
  #   elsif !params[:foods][:name].blank?
  #     name = params[:foods][:name]
  #     Food.create(name: name, serving: serving)
  #   end
  # end
end
