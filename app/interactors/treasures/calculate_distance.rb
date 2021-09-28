# frozen_string_literal: true

module Treasures
  include Interactor

  class CalculateDistance
    include Interactor
    include InteractorValidations

    delegate :email, :longitute, :latitude, to: :context

    requires :email, :longitute, :latitude

    def call
      context.distance = calculate_distance
    rescue ArgumentError => error
      binding.pry
    end

    private

    def calculate_distance
      10
    end
  end
end
