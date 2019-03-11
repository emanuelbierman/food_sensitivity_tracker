class DaysSymptom < ActiveRecord::Base
  belongs_to :day
  belongs_to :symptom
  validates_presence_of :frequency, :day_id
  accepts_nested_attributes_for :symptom

  def symptom_attributes=(attributes)
    unless attributes[:description].blank?
      self.symptom = Symptom.find_or_create_by(description: attributes[:description].downcase)
    end
  end

  # def self.create_symptom_from(params)
  #   frequency = params[:symptoms][:frequency].to_i
  #   if !params[:symptom_id].blank?
  #     symptom = Symptom.find_by(id: params[:symptom_id].to_i)
  #     Symptom.create(description: symptom.description, frequency: frequency)
  #   elsif !params[:symptoms][:description].blank?
  #     description = params[:symptoms][:description]
  #     Symptom.create(description: description, frequency: frequency)
  #   end
  # end
end
