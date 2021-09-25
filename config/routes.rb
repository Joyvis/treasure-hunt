Rails.application.routes.draw do
  post :treasure_hunt, to: 'treasure_hunt#calculate_distance'
end
