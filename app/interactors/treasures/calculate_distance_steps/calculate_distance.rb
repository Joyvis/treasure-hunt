# frozen_string_literal: true

module Treasures
  module CalculateDistanceSteps
    class CalculateDistance
      include Interactor
      include InteractorValidations

      EARTH_RADIUS_METERS = 6371 * 1000
      RADIUS_PER_DEGREE = Math::PI / 180

      delegate :email, :longitude, :latitude, to: :context

      requires :email, :longitude, :latitude

      def call
        context.distance = distance_between
      end

      private

      def distance_between
        current_lat_radius, current_lon_radius = current_radius
        treasure_lat_radius, treasure_lon_radius = treasure_radius

        a = Math.sin(delta_lat_radius / 2) ** 2 + Math.cos(current_lat_radius) *
          Math.cos(treasure_lat_radius) * Math.sin(delta_lon_radius / 2) ** 2
        c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1 - a))

        (EARTH_RADIUS_METERS * c).round(2)
      end

      def delta_lat_radius
        @delta_lat_radius ||=
          (treasure_position.first - current_position.first) * RADIUS_PER_DEGREE
      end

      def delta_lon_radius
        @delta_lon_radius ||=
          (treasure_position.last - current_position.last) * RADIUS_PER_DEGREE
      end

      def current_radius
        current_position.map { |position| position * RADIUS_PER_DEGREE }
      end

      def treasure_radius
        treasure_position.map { |position| position * RADIUS_PER_DEGREE }
      end

      def position_string_to_decimal(latitude_string, longitude_string)
        longitude_string = longitude_string.split(' ')
        lon = longitude_string.first.to_f
        lon = lon * (-1) if longitude_string.last == 'W'


        latitude_string = latitude_string.split(' ')
        lat = latitude_string.first.to_f
        lat = lat * (-1) if latitude_string.last == 'S'

        [lat, lon]
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
end
