require 'rspec'
require_relative 'triage_keyword_filter'

describe 'triage keyword filter' do
  it 'returns true for chest pain or pressure' do
    filter = TriageKeywordFilter.new

    expect(filter.emergent?('I have pain in my chest')).to eq true
    expect(filter.emergent?('I sprained my ankle and have significant ankle pain and a rash on my chest')).to eq true
    expect(filter.emergent?('I have a squeezing feeling in my chest')).to eq true
  end

  it 'returns false for only partial matches' do
    filter = TriageKeywordFilter.new

    expect(filter.emergent?('I have a left arm')).to eq false
    expect(filter.emergent?('once, I felt pain!')).to eq false
  end

  it 'returns true for left arm pain or pressure' do
    filter = TriageKeywordFilter.new

    expect(filter.emergent?('I have shooting pain in my left arm')).to eq true
    expect(filter.emergent?('I have a pressing feeling in my left arm')).to eq true
    expect(filter.emergent?('my left arm is very painful')).to eq true
  end

  it 'returns true for shortness of breath' do
    filter = TriageKeywordFilter.new

    expect(filter.emergent?('I am experiencing shortness of breath')).to eq true
    expect(filter.emergent?('I am experiencing SOB')).to eq true
    expect(filter.emergent?('I am experiencing s.o.b.')).to eq true
    expect(filter.emergent?('I am having difficulty breathing')).to eq true
  end

  it 'returns false for non-breath related short or difficulty sentences' do
    filter = TriageKeywordFilter.new

    expect(filter.emergent?('I am having difficulty adjusting to new life changes')).to eq false
    expect(filter.emergent?('I have a new short brown mark on my skin')).to eq false
  end

  it 'returns true for slurred speech' do
    filter = TriageKeywordFilter.new

    expect(filter.emergent?('I think my speech is slurred')).to eq true
    expect(filter.emergent?('I am slurring my speech')).to eq true
    expect(filter.emergent?('I am speaking with a slur')).to eq true
  end

  it 'returns false for non-speech or non-slur related sentences' do
    filter = TriageKeywordFilter.new

    expect(filter.emergent?('I drank a slurpee too fast and got a headache')).to eq false
    expect(filter.emergent?('I am very nervous about public speaking')).to eq false
  end
end
