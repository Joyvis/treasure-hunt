# frozen_string_literal: true

module Treasures
  class CalculateDistance
    include Interactor::Organizer

    organize CalculateDistanceSteps::LimitUserRequests,
             CalculateDistanceSteps::CalculateDistance,
             CalculateDistanceSteps::SendEmailTreasurePosition,
             CalculateDistanceSteps::SendEmailTreasureFound,
             CalculateDistanceSteps::SaveUserRequest
  end
end
