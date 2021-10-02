# frozen_string_literal: true

FactoryBot.define do
  factory :user_request do
    email { 'test@test.io' }
    latitude { '50.051227 N' }
    longitude { '19.945704 E' }
    distance { 10 }
  end
end
