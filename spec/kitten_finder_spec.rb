# frozen_string_literal: true

RSpec.describe KittenFinder do
  it 'returns a success' do
    expect(subject.find_kittens).to eql true
  end
end
