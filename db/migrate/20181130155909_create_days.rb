class CreateDays < ActiveRecord::Migration[5.2]
  def change
    create_table :days do |t|
      t.string :month_day_year
      t.string :day_of_week
      t.string :comments
      t.datetime :created_at
      t.belongs_to :user
    end
  end
end
