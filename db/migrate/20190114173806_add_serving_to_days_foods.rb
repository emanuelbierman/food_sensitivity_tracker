class AddServingToDaysFoods < ActiveRecord::Migration[5.2]
  def change
    add_column :days_foods, :serving, :integer
  end
end
