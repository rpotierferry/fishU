Rails.application.routes.draw do
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check

  root "tanks#index"
  post '/tanks', to: 'tanks#create', as: 'create_tank'
  resources :tanks do
    resources :fish
    member do
      post 'feed'
      post 'add_plant'
      post 'bubble'
      post 'plant_action'
      post 'add_lamp'
      post 'increase_tank_size'
      post 'new_day'
      post 'reset_all'
      get 'details_death'
    end
  end
end
