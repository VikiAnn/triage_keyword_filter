class TriageKeywordFilter
  def emergent?(patient_symptoms)
    @words = patient_symptoms.split(' ')

    possible_angina?
  end

  private

  def possible_angina?
    chest_or_left_arm? && corresponding_symptoms?(angina_symptoms)
  end

  def chest_or_left_arm?
    @words.any? { |word| word == 'chest' || 'left arm' }
  end

  def angina_symptoms
    ['pain', 'pressure', 'pressing', 'squeezed', 'squeezing']
  end

  def corresponding_symptoms?(symptoms)
    @words.any? do |word|
      symptoms.any? { |symptom| symptom == word }
    end
  end
end
