# frozen_string_literal: true

class TreasureHuntController < ApplicationController
  def distance
    result = calculate_distance

    if result.success?
      render json: distance_response(:ok, result), status: :ok
    else
      render json: distance_response(:error, result), status: :bad_request
    end
  end

  def analytics
    result = UserRequests::List.call(analytics_params)

    if result.success?
      render json: analytics_response(:ok, result.requests), status: :ok
    else
      render json: analytics_response(:error), status: :bad_request
    end
  end

  private

  def calculate_distance
    Treasures::CalculateDistance.call(
      email: params[:email],
      longitude: params[:current_location]&.first,
      latitude: params[:current_location]&.last
    )
  end

  def distance_response(status, result)
    response_body = {
      status: status,
      distance: result.distance || -1
    }
    response_body[:error] = result.error unless status == :ok

    response_body
  end

  def analytics_response(status, requests = [])
    {
      status: status,
      requests: serialize_requests(requests)
    }
  end

  def analytics_params
    params.permit(:start_time, :end_time, :radius)
  end

  def serialize_requests(requests)
    ActiveModelSerializers::SerializableResource.new(
      requests,
      each_serializer: UserRequestSerializer
    )
  end
end
