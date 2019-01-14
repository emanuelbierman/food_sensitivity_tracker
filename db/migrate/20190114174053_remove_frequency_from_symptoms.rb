class RemoveFrequencyFromSymptoms < ActiveRecord::Migration[5.2]
  def change
    remove_column :symptoms, :frequency, :integer
  end
end
