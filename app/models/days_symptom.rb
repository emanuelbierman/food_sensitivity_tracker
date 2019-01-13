class DaysSymptom < ActiveRecord::Base
  belongs_to :day
  belongs_to :symptom

  def self.create_symptom_from(params)
    frequency = params[:symptoms][:frequency].to_i
    if !params[:symptom_id].blank?
      symptom = Symptom.find_by(id: params[:symptom_id].to_i)
      Symptom.create(description: symptom.description, frequency: frequency)
    elsif !params[:symptoms][:description].blank?
      description = params[:symptoms][:description]
      Symptom.create(description: description, frequency: frequency)
    end
  end
end
