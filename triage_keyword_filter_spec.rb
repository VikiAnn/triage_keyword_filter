require 'rspec'
require_relative 'triage_keyword_filter'

describe 'triage keyword filter' do
  it 'identifies chest pain' do
    filter = TriageKeywordFilter.new

    expect(filter.emergent?('I have pain in my chest')).to eq true
  end
end
