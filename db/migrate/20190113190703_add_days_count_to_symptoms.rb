class AddDaysCountToSymptoms < ActiveRecord::Migration[5.2]
  def change
    add_column :symptoms, :days_count, :integer
  end
end
