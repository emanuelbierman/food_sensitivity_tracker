class CreateFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :foods do |t|
      t.string :name
      t.integer :serving
      t.integer :days_count
    end
  end
end
