class RemoveServingFromFoods < ActiveRecord::Migration[5.2]
  def change
    remove_column :foods, :serving, :integer
  end
end
