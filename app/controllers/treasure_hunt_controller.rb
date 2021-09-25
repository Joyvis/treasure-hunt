# frozen_string_literal: true

class TreasureHuntController < ApplicationController
  def calculate_distance
    render json: { status: :ok, distance: 10 }, status: :ok
  end

  private

  def treasure_hunt_param
    params.permits(:email, current_location: [:longitute, :latitude])
  end
end
