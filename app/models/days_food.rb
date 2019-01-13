class DaysFood < ActiveRecord::Base
  belongs_to :day
  belongs_to :food

  def self.create_food_from(params)
    serving = params[:foods][:serving].to_i
    if !params[:food_id].blank?
      food = Food.find_by(id: params[:food_id].to_i)
      Food.create(name: food.name, serving: serving)
    elsif !params[:foods][:name].blank?
      name = params[:foods][:name]
      Food.create(name: name, serving: serving)
    end
  end
end
