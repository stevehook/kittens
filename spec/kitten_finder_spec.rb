# frozen_string_literal: true

require_relative '../lib/kitten_finder'
require 'webmock/rspec'

RSpec.describe KittenFinder do
  let(:directions_response) { '{"directions":["forward","right","forward","forward","forward","left","forward","forward","left","right","forward","right","forward","forward","right","forward","forward","left"]}' }
  let(:response_code) { 200 }
  before do
    stub_request(
      :get,
      KittenFinder::DIRECTIONS_URL
    ).with(
      headers: {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Host' => 'which-technical-exercise.herokuapp.com',
        'User-Agent' => 'Ruby'
      }
    ).to_return(
      status: response_code,
      body: directions_response,
      headers: {}
    )
  end

  context 'when directions API returns valid directions' do
    it 'returns a success' do
      expect(subject.find).to eql true
    end
  end

  context 'when directions API returns a 500 error' do
    let(:directions_response) { '' }
    let(:response_code) { 500 }

    it 'raises an exception' do
      expect{ subject.find }.to raise_error 'Directions API returned a non-success code 500'
    end
  end
end
