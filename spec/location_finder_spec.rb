# frozen_string_literal: true

require_relative '../lib/location_finder'

RSpec.describe LocationFinder do
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

    context 'when moving forward one position, turning left and moving forward twice more' do
      let(:directions) { %w[forward left forward forward] }
      it 'returns coordinates (-2, 1)' do
        expect(subject.evaluate(directions)).to eql [-2, 1]
      end
    end

    context 'when applying the full directions' do
      let(:directions) { %w[forward right forward forward forward left forward forward left right forward right forward forward right forward forward left] }
      it 'returns coordinates (5, 2)' do
        expect(subject.evaluate(directions)).to eql [5, 2]
      end
    end
  end
end
