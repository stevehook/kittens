# frozen_string_literal: true

require 'net/http'
require 'json'

class KittenFinder
  def find
    # 1. Fetch instructions from `/api/:email/directions`
    directions = fetch_directions

    # 2. Calculate target coordinates
    x, y = LocationFinder.new(directions).coordinates

    # 3. Call /api/:email/location/:x/:y to send search party
    search_response = send_location(x, y)

    # 4. Return success or failure
    # TODO Parse the response
    true
  end

  EMAIL = 'steve.hook@gmail.com'
  DIRECTIONS_URL = "http://which-technical-exercise.herokuapp.com/api/#{EMAIL}/directions"
  LOCATION_URL = "http://which-technical-exercise.herokuapp.com/api/#{EMAIL}/location/:x/:y"

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

  def send_location(x, y)
    # uri = URI.parse(LOCATION_URL)
    # response = Net::HTTP.get_response(uri)
    # if response.code == '200'
    #   results = JSON.parse(response.body)
    #   # TODO: Find out what format the response is in
    # else
    #   raise "Location API returned a non-success code #{response.code}".to_s
    # end
    {}
  end
end
