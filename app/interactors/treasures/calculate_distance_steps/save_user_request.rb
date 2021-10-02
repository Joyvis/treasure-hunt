# frozen_string_literal: true

module Treasures
  module CalculateDistanceSteps
    class SaveUserRequest
      include Interactor
      include InteractorValidations

      delegate :email, :latitude, :longitude, :distance, to: :context

      requires :email, :latitude, :longitude, :distance

      def call
        context.user_request = save_user_request
      end

      private

      def save_user_request
        UserRequest.new.tap do |user_request|
          user_request.email = email
          user_request.latitude = latitude
          user_request.longitude = longitude
          user_request.distance = distance
          user_request.save!
        end
      end
    end
  end
end
