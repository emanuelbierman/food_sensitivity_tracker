class CreateDaysFood < ActiveRecord::Migration[5.2]
  def change
    create_table :days_foods do |t|
      t.string :comments
      t.belongs_to :day, index: true
      t.belongs_to :food, index: true
    end
  end
end
