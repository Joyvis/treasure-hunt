# frozen_string_literal: true

module Treasures
  module CalculateDistanceSteps
    class LimitUserRequests
      include Interactor
      include InteractorValidations

      delegate :email, to: :context

      requires :email

      def call
        unless request_last_hour < 20
          context.fail!(error: '20 request per hour limit reached')
        end
      end

      private

      def request_last_hour
        now = Time.now

        UserRequest.
          where(email: email).
          where(created_at: (now - 1.hour)..now).
          count
      end
    end
  end
end
