# frozen_string_literal: true

require 'rails_helper'

describe Treasures::CalculateDistance do
  it 'organizes steps to calculate distance between two points' do
    expect(described_class.organized).to eq [
      Treasures::CalculateDistanceSteps::LimitUserRequests,
      Treasures::CalculateDistanceSteps::CalculateDistance,
      Treasures::CalculateDistanceSteps::SendEmailTreasurePosition,
      Treasures::CalculateDistanceSteps::SendEmailTreasureFound,
      Treasures::CalculateDistanceSteps::SaveUserRequest
    ]
  end
end
