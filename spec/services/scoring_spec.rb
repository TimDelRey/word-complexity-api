require 'rails_helper'

RSpec.describe Scoring, type: :service do
  subject(:scoring) { described_class.new(result_struct) }

  let(:non_zero_data) { JSON.parse(File.read(Rails.root.join("spec/fixtures/non_zero.json"))) }
  let(:zero_definitions_data) { JSON.parse(File.read(Rails.root.join("spec/fixtures/zero_definitions.json"))) }
  let(:zero_syn_ant_data) { JSON.parse(File.read(Rails.root.join("spec/fixtures/zero_syn_ant.json"))) }



  describe '#call' do
    context 'when definitions, synonyms, antonyms exist' do
      let(:result_struct) do
        double("ResultStruct", success?: true, data: non_zero_data)
      end
      it 'returns non-zero score' do
        score = scoring.call
        expect(score).to be > 0
      end
    end

    context 'when definitions are zero' do
      let(:result_struct) do
        double("ResultStruct", success?: true, data: zero_definitions_data)
      end
      it 'returns 0' do
        score = scoring.call
        expect(score).to eq(0)
      end
    end

    context 'when synonyms and antonyms are zero' do
      let(:result_struct) do
        double("ResultStruct", success?: true, data: zero_syn_ant_data)
      end
      it 'returns 0' do
        score = scoring.call
        expect(score).to eq(0)
      end
    end
  end
end
