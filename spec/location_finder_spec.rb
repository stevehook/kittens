# frozen_string_literal: true

require_relative '../lib/location_finder'

RSpec.describe LocationFinder do
  # let(:directions) { ["forward","right","forward","forward","forward","left","forward","forward","left","right","forward","right","forward","forward","right","forward","forward","left"] }

  describe '#coordinates' do
    context 'when moving forward one position' do
      let(:directions) { ['forward'] }
      it 'returns coordinates (0, 1)' do
        expect(subject.evaluate(directions)).to eql [0, 1]
      end
    end

    context 'when moving forward one position, turning right and moving forward again' do
      let(:directions) { %w[forward right forward] }
      it 'returns coordinates (1, 1)' do
        expect(subject.evaluate(directions)).to eql [1, 1]
      end
    end
  end
end
