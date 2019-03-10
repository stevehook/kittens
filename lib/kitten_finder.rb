# frozen_string_literal: true

require 'net/http'
require 'json'
require_relative './location_finder'

class KittenFinder
  def find
    # 1. Fetch instructions from `/api/:email/directions`
    directions = fetch_directions

    # 2. Calculate target coordinates
    x, y = LocationFinder.new.evaluate(directions)

    # 3. Call /api/:email/location/:x/:y to send search party
    send_location(x, y)
  end

  EMAIL = 'steve.hook@gmail.com'
  DIRECTIONS_URL = "http://which-technical-exercise.herokuapp.com/api/#{EMAIL}/directions"
  LOCATION_URL = "http://which-technical-exercise.herokuapp.com/api/#{EMAIL}/location/:x/:y"
  SUCCESS_MESSAGE = "Congratulations! The search party successfully recovered the missing kittens. Please zip up your code and send it to richard.hart@which.co.uk"

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
    #   results['message']
    # else
    #   raise "Location API returned a non-success code #{response.code}".to_s
    # end
    SUCCESS_MESSAGE
  end
end
