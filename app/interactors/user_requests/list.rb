# frozen_string_literal: true

module UserRequests
  class List
    include Interactor
    include InteractorValidations

    delegate :start_time, :end_time, :radius, to: :context

    requires :start_time, :end_time

    def call
      context.requests = list_user_requests
    end

    private

    def list_user_requests
      UserRequest
        .where(created_at: start_time.to_time..end_time.to_time)
        .where(radius_condition)
    end

    def radius_condition
      "distance <= #{radius}" if radius.present?
    end
  end
end
