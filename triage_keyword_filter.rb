class TriageKeywordFilter
  def emergent?(patient_symptoms)
    @patient_symptoms = patient_symptoms
    @words            = clean(patient_symptoms.split(' '))

    possible_angina? ||
    possible_breathing_problem? ||
    slurring_speech?
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

  def slurring_speech?
    speech_related? && corresponding_symptoms?(slurring_symptoms)
  end

  def chest_or_left_arm?
    @words.any? { |word| word == 'chest' } || @patient_symptoms.include?('left arm')
  end

  def breath_related?
    @words.any? { |word| word.start_with?('breath') || word == 'sob' }
  end

  def speech_related?
    @words.any? { |word| word.start_with?('speak') || word == 'speech' }
  end

  def angina_symptoms
    ['pain', 'pains', 'painful', 'pressure', 'pressing', 'squeezed', 'squeezing']
  end

  def breathing_symptoms
    ['difficult', 'difficulty', 'short', 'shortness', 'sob']
  end

  def slurring_symptoms
    ['slur', 'slurred', 'slurring', 'slurs']
  end

  def corresponding_symptoms?(symptoms)
    @words.any? do |word|
      symptoms.any? { |symptom| symptom == word }
    end
  end
end
