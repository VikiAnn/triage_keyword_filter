class TriageKeywordFilter
  def emergent?(patient_symptoms)
    words = patient_symptoms.split(' ')

    if words.any? { |word| word == 'chest' || 'left arm' }
      words.any? do |word|
        angina_symptoms.any? { |symptom| symptom == word }
      end
    else
      false
    end
  end

  private

  def angina_symptoms
    ['pain', 'pressure', 'pressing', 'squeezed', 'squeezing']
  end
end
