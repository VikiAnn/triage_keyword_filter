require 'rspec'
require_relative 'triage_keyword_filter'

describe 'triage keyword filter' do
  it 'returns true for chest pain' do
    filter = TriageKeywordFilter.new

    expect(filter.emergent?('I have pain in my chest')).to eq true
  end

  it 'returns true for left arm pain' do
    filter = TriageKeywordFilter.new

    expect(filter.emergent?('I have pain in my left arm')).to eq true
  end
end
