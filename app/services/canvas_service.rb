require 'net/http'
require 'json'
require 'uri'

class CanvasService
  class ApiError < StandardError; end

  def initialize
    @token = ENV['CANVAS_API_TOKEN']
    @base_url = ENV['CANVAS_BASE_URL']

    raise ApiError, "Missing CANVAS_API_TOKEN in environment variables." if @token.blank?
    raise ApiError, "Missing CANVAS_BASE_URL in environment variables." if @base_url.blank?
  end

  # Endpoint 1: Retrieve active courses for the student
  def fetch_courses
    get_paginated("/api/v1/courses?enrollment_state=active")
  end

  # Endpoint 2: Retrieve assignments for a specific course ID (user input)
  def fetch_assignments(course_id)
    get_paginated("/api/v1/courses/#{course_id}/assignments")
  end

  private

  def get_paginated(endpoint)
    url = URI("#{@base_url}#{endpoint}")
    results = []

    loop do
      request = Net::HTTP::Get.new(url)
      request['Authorization'] = "Bearer #{@token}"
      request['Accept'] = 'application/json'

      response = Net::HTTP.start(url.host, url.port, use_ssl: url.scheme == 'https') do |http|
        http.request(request)
      end

      unless response.is_a?(Net::HTTPSuccess)
        raise ApiError, "Canvas API Error [#{response.code}]: #{response.body}"
      end

      data = JSON.parse(response.body)
      results.concat(data.is_a?(Array) ? data : [data])

      # Follow Canvas 'Link' header for pagination
      link_header = response['Link']
      break if link_header.blank?

      next_link = parse_next_link(link_header)
      break unless next_link

      url = URI(next_link)
    end

    results
  end

  # Parses 'Link: <...>; rel="next"' header
  def parse_next_link(header)
    links = header.split(',')
    next_link = links.find { |link| link.include?('rel="next"') }
    return nil unless next_link

    next_link[/<(.*?)>/, 1]
  end
end