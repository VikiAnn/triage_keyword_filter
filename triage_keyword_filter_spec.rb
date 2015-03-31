require 'rspec'
require_relative 'triage_keyword_filter'

describe '#emergent?' do
  context 'possible angina' do
    it 'returns true for chest pain or pressure' do
      filter = TriageKeywordFilter.new

      expect(filter.emergent?('I have pain in my chest')).to eq true
      expect(filter.emergent?('I sprained my ankle and have significant ankle pain and a rash on my chest')).to eq true
      expect(filter.emergent?('I have a squeezing feeling in my chest')).to eq true
    end

    it 'returns true for left arm pain or pressure' do
      filter = TriageKeywordFilter.new

      expect(filter.emergent?('I have shooting pain in my left arm')).to eq true
      expect(filter.emergent?('I have a pressing feeling in my left arm')).to eq true
      expect(filter.emergent?('my left arm is very painful')).to eq true
    end

    it 'returns false for partial matches' do
      filter = TriageKeywordFilter.new

      expect(filter.emergent?('I have a left arm')).to eq false
      expect(filter.emergent?('once, I felt pain!')).to eq false
    end
  end

  context 'breathing problems' do
    it 'returns true for shortness of breath' do
      filter = TriageKeywordFilter.new

      expect(filter.emergent?('I am experiencing shortness of breath')).to eq true
      expect(filter.emergent?('I am experiencing SOB')).to eq true
      expect(filter.emergent?('I am experiencing s.o.b.')).to eq true
      expect(filter.emergent?('I am having difficulty breathing')).to eq true
    end

    it 'returns false for partial matches' do
      filter = TriageKeywordFilter.new

      expect(filter.emergent?('I am having difficulty adjusting to new life changes')).to eq false
      expect(filter.emergent?('I have a new short brown mark on my skin')).to eq false
    end
  end

  context 'slurred speech' do
    it 'returns true for slurred speech' do
      filter = TriageKeywordFilter.new

      expect(filter.emergent?('I think my speech is slurred')).to eq true
      expect(filter.emergent?('I am slurring my speech')).to eq true
      expect(filter.emergent?('I am speaking with a slur')).to eq true
    end

    it 'returns false for partial matches' do
      filter = TriageKeywordFilter.new

      expect(filter.emergent?('I drank a slurpee too fast and got a headache')).to eq false
      expect(filter.emergent?('I am very nervous about public speaking')).to eq false
    end

    it 'returns true for numbness in arm, leg or face' do
      filter = TriageKeywordFilter.new

      expect(filter.emergent?('My face feels numb')).to eq true
      expect(filter.emergent?('I have numbness in my arm')).to eq true
      expect(filter.emergent?('My leg feels numb')).to eq true
    end

    it 'returns false for partial matches' do
      filter = TriageKeywordFilter.new

      expect(filter.emergent?('The scar from my incision is a little numb')).to eq false
      expect(filter.emergent?('My leg bothers me after I go running')).to eq false
    end
  end

  context 'heart rate' do
    it 'returns true for rapid heart rate' do
      filter = TriageKeywordFilter.new

      expect(filter.emergent?('My mother has a very rapid heart rate')).to eq true
      expect(filter.emergent?('My heart is beating too fast')).to eq true
      expect(filter.emergent?('I have a rapid heartbeat')).to eq true
    end

    it 'returns false for partials matches' do
      filter = TriageKeywordFilter.new

      expect(filter.emergent?('I was running rapidly and I tripped and fell')).to eq false
      expect(filter.emergent?('I have been experiencing mild heart burn')).to eq false
    end
  end

  context 'triggering phrases or individual words' do
    it 'returns true for any of the individual triggering words' do
      filter = TriageKeywordFilter.new

      expect(filter.emergent?('I am thinking about suicide')).to eq true
      expect(filter.emergent?('I think my mother is having a stroke')).to eq true
      expect(filter.emergent?('I have been experiencing heart palpitations')).to eq true
      expect(filter.emergent?('I had an episode of syncope')).to eq true
      expect(filter.emergent?('I think it is pancreatitis')).to eq true
      expect(filter.emergent?('I have cardiac issues')).to eq true
      expect(filter.emergent?('My mother just had a seizure')).to eq true
      expect(filter.emergent?('I have tachycardia')).to eq true
      expect(filter.emergent?('I want to kill someone')).to eq true
    end

    it 'returns true if triggering phrases are present' do
      filter = TriageKeywordFilter.new

      expect(filter.emergent?('I think my coworker is having a heart attack')).to eq true
      expect(filter.emergent?('I have bad abdominal pain')).to eq true
      expect(filter.emergent?('My roommate passed out onto the floor')).to eq true
      expect(filter.emergent?('I am having an asthma attack')).to eq true
    end
  end
end
