require_relative 'keyword_lists'

class TriageKeywordFilter
  include KeywordLists

  def emergent?(patient_report)
    @patient_report = patient_report
    @words          = clean(patient_report.split(' '))

    emergent_conditions.any?
  end

  private

  attr_reader :words, :patient_report

  def clean(words)
    words.map do |word|
      word.downcase.gsub(/[^a-z]/, '')
    end
  end

  def emergent_conditions
    [ possible_angina?,
      possible_breathing_problem?,
      slurring_speech?,
      numbness_in_extremities?,
      rapid_heart_rate?,
      triggers_in_any_context?,
      triggering_phrases? ]
  end

  def possible_angina?
    chest_or_left_arm? && contains_words_from?(angina_symptoms)
  end

  def possible_breathing_problem?
    breath_related? && contains_words_from?(breathing_symptoms)
  end

  def slurring_speech?
    speech_related? && contains_words_from?(slurring_symptoms)
  end

  def numbness_in_extremities?
    contains_words_from?(extremities) && contains_words_from?(numbness)
  end

  def rapid_heart_rate?
    rapid? && contains_words_from?(heart_rate)
  end

  def triggers_in_any_context?
    contains_words_from?(any_context_triggers)
  end

  def triggering_phrases?
    triggering_phrases.any? { |phrase| patient_report.include?(phrase) }
  end

  def contains_words_from?(symptoms)
    words.any? do |word|
      symptoms.any? { |symptom| symptom == word }
    end
  end

  def chest_or_left_arm?
    words.any? { |word| word == 'chest' } || patient_report.include?('left arm')
  end

  def breath_related?
    words.any? { |word| word.start_with?('breath') || word == 'sob' }
  end

  def speech_related?
    words.any? { |word| word.start_with?('speak') || word == 'speech' }
  end

  def rapid?
    words.any? { |word| word.start_with?('rapid') || word == 'fast' }
  end
end
