# frozen_string_literal: true

module Treasures
  module CalculateDistanceSteps
    class SendEmailTreasurePosition
      include Interactor

      def call
        position_email = TreasureMailer.position_email
        position_email.deliver_now
      end
    end
  end
end
