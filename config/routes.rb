# frozen_string_literal: true

Rails.application.routes.draw do
  post :treasure_hunt, to: 'treasure_hunt#distance'
  get :analytics, to: 'treasure_hunt#analytics'
end
