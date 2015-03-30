class TriageKeywordFilter
  def emergent?(patient_symptoms)
    words = patient_symptoms.split(' ')

    if words.any? { |word| word == 'chest' }
      words.any? { |word| word == 'pain' }
    else
      false
    end
  end
end
