Rails.application.routes.draw do
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check

  root "tanks#index"
  resources :tanks do
  member do
    post 'feed'
    post 'add_plant'
    post 'bubble'
    post 'plant_action'
    post 'add_lamp'
    post 'increase_tank_size'
    post 'new_day'
  end
end
end
