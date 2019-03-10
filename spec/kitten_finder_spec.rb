# frozen_string_literal: true

require_relative '../lib/kitten_finder'
require 'webmock/rspec'

RSpec.describe KittenFinder do
  let(:directions_response) { '{"directions":["forward","right","forward","forward","forward","left","forward","forward","left","right","forward","right","forward","forward","right","forward","forward","left"]}' }
  let(:location_response) { '{"message":"Congratulations! The search party successfully recovered the missing kittens. Please zip up your code and send it to richard.hart@which.co.uk"}' }
  let(:directions_response_code) { 200 }
  let(:location_response_code) { 200 }
  let(:x) { 5 }
  let(:y) { 2 }

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
      status: directions_response_code,
      body: directions_response,
      headers: {}
    )

    stub_request(
      :get,
      "#{KittenFinder::LOCATION_URL}/#{x}/#{y}"
    ).with(
      headers: {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Host' => 'which-technical-exercise.herokuapp.com',
        'User-Agent' => 'Ruby'
      }
    ).to_return(
      status: location_response_code,
      body: location_response,
      headers: {}
    )
  end

  context 'when directions API returns valid directions' do
    context 'when location API returns a successful search message' do
      it 'returns a success' do
        expect(subject.find).to eql KittenFinder::SUCCESS_MESSAGE
      end
    end

    context 'when location API returns a 500 error' do
      let(:location_response) { '' }
      let(:location_response_code) { 500 }

      it 'raises an exception' do
        expect{ subject.find }.to raise_error 'Location API returned a non-success code 500'
      end
    end

    context 'when location API returns a failed search message' do
      let(:location_response) { '{"message":"Unfortunately, the search party failed to recover the missing kittens. You have 4 attempts remaining."}' }

      it 'returns a failure message' do
        expect(subject.find).to eql 'Unfortunately, the search party failed to recover the missing kittens. You have 4 attempts remaining.'
      end
    end
  end

  context 'when directions API returns a 500 error' do
    let(:directions_response) { '' }
    let(:directions_response_code) { 500 }

    it 'raises an exception' do
      expect{ subject.find }.to raise_error 'Directions API returned a non-success code 500'
    end
  end
end
