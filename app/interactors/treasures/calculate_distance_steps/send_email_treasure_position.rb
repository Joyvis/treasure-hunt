# frozen_string_literal: true

module Treasures
  module CalculateDistanceSteps
    class SendEmailTreasurePosition
      include Interactor
      include InteractorValidations

      delegate :distance, :email, to: :context

      requires :distance

      def call
        send_email if distance <= 5 && distance > 0
      end

      private

      def send_email
        position_email = TreasureMailer.with(email: email).position_email
        position_email.deliver_now
      end
    end
  end
end
