# frozen_string_literal: true

module Treasures
  include Interactor

  class CalculateDistance
    include Interactor
    include InteractorValidations

    EARTH_RADIUS_METERS = 6371 * 1000
    RADIUS_PER_DEGREE = Math::PI/180

    delegate :email, :longitude, :latitude, to: :context

    requires :email, :longitude, :latitude

    def call
      binding.pry
      context.distance = distance_between
    end

    private

    def distance_between
      delta_lat_radius = (treasure_position.first - current_position.first) * RADIUS_PER_DEGREE
      delta_lon_radius = (treasure_position.last - current_position.last) * RADIUS_PER_DEGREE

      current_lat_radius, current_lon_radius = current_position.map { |i| i * RADIUS_PER_DEGREE }
      treasure_lat_radius, treasure_lon_radius = treasure_position.map { |i| i * RADIUS_PER_DEGREE }

      a = Math.sin(delta_lat_radius/2)**2 + Math.cos(current_lat_radius) * Math.cos(treasure_lat_radius) * Math.sin(delta_lon_radius/2)**2
      c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

      EARTH_RADIUS_METERS * c
    end

    def position_string_to_decimal(latitude_string, longitude_string)
      longitude_string = longitude_string.split(' ')
      lon = longitude_string.first
      lon = lon * (-1) if longitude_string.last == 'W'


      latitude_string = latitude_string.split(' ')
      lat = latitude_string.first
      lat = lat * (-1) if latitude_string.last == 'S'

      [lat.to_f, lon.to_f]
    end


    def current_position
      @current_position ||= position_string_to_decimal(latitude, longitude)
    end

    def treasure_position
      @treasure_position ||= position_string_to_decimal(
        ENV['TREASURE_LATITUDE'],
        ENV['TREASURE_LONGITUDE']
      )
    end
  end
end
