class CreateDaysSymptoms < ActiveRecord::Migration[5.2]
  def change
    create_table :days_symptoms do |t|
      t.belongs_to :day, index: true
      t.belongs_to :symptom, index: true
    end
  end
end
