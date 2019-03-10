# frozen_string_literal: true

require 'net/http'
require 'json'

class KittenFinder
  def find
    # TODO:
    # 1. Fetch instructions from `/api/:email/directions`
    directions = fetch_directions
    # 2. Calculate target coordinates
    # 3. Call /api/:email/location/:x/:y to send search party
    # 3. Return success or failure
    true
  end

  EMAIL = 'steve.hook@gmail.com'
  DIRECTIONS_URL = "http://which-technical-exercise.herokuapp.com/api/#{EMAIL}/directions"

  def fetch_directions
    uri = URI.parse(DIRECTIONS_URL)
    response = Net::HTTP.get_response(uri)
    if response.code == '200'
      results = JSON.parse(response.body)
      results['directions']
    else
      raise "Directions API returned a non-success code #{response.code}".to_s
    end
  end
end
