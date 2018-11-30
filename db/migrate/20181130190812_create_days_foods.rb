class CreateDaysFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :days_foods do |t|
      t.belongs_to :day_id, index: true
      t.belongs_to :food_id, index: true
    end
  end
end
