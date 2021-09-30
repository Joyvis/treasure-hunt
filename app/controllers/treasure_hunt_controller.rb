# frozen_string_literal: true

class TreasureHuntController < ApplicationController
  def distance
    result = calculate_distance

    if result.success?
      render json: http_response(:ok, result), status: :ok
    else
      render json: http_response(:error, result), status: :bad_request
    end
  end

  private

  def calculate_distance
    Treasures::CalculateDistance.call(
      email: params[:email],
      longitude: params[:current_location].first,
      latitude: params[:current_location].last
    )
  end

  def http_response(status, result)
    {
      status: status,
      distance: result.distance || -1,
      error: result.error
    }
  end
end
