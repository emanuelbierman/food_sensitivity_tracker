class AddFrequencyToDaysSymptoms < ActiveRecord::Migration[5.2]
  def change
    add_column :days_symptoms, :frequency, :integer
  end
end
