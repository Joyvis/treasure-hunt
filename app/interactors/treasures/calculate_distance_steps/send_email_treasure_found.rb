# frozen_string_literal: true

module Treasures
  module CalculateDistanceSteps
    class SendEmailTreasureFound
      include Interactor
      include InteractorValidations

      delegate :distance, :email, to: :context

      requires :distance, :email

      def call
        if distance == 0
          context.treasure_finder_count = treasure_finder_count
          send_email
        end
      end

      private

      def send_email
        found_email = TreasureMailer
          .with(email: email, treasure_finder_count: treasure_finder_count)
          .found_email
        found_email.deliver_now
      end

      def treasure_finder_count
        # using distinct to avoid a duplicated finder
        @treasure_finder_count ||=
          UserRequest.select(:email).distinct.where(distance: 0).count + 1
      end
    end
  end
end
