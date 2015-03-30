class TriageKeywordFilter
  def emergent?(patient_symptoms)
    @words = clean(patient_symptoms.split(' '))

    possible_angina? ||
    possible_breathing_problem?
  end

  private

  def clean(words)
    words.map do |word|
      word.downcase.gsub(/[^a-z]/, '')
    end
  end

  def possible_angina?
    chest_or_left_arm? && corresponding_symptoms?(angina_symptoms)
  end

  def possible_breathing_problem?
    breath_related? && corresponding_symptoms?(breathing_symptoms)
  end

  def chest_or_left_arm?
    @words.any? { |word| word == 'chest' || 'left arm' }
  end

  def breath_related?
    @words.any? { |word| word.start_with?('breath') || word == 'sob' }
  end

  def angina_symptoms
    ['pain', 'pressure', 'pressing', 'squeezed', 'squeezing']
  end

  def breathing_symptoms
    ['difficult', 'difficulty', 'short', 'shortness', 'sob']
  end

  def corresponding_symptoms?(symptoms)
    @words.any? do |word|
      symptoms.any? { |symptom| symptom == word }
    end
  end
end
