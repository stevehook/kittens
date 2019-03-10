# frozen_string_literal: true

RSpec.describe LocationFinder do
  # let(:directions) { ["forward","right","forward","forward","forward","left","forward","forward","left","right","forward","right","forward","forward","right","forward","forward","left"] }
  subject { described_class.new(directions) }

  context 'when moving forward one position' do
    let(:directions) { ['forward'] }
    it 'returns coordinates (0, 1)' do
      expect(subject.coordinates).to eql [0, 1]
    end
  end
end
