class DaysSymptom < ActiveRecord::Base
  belongs_to :day
  belongs_to :symptom
end
