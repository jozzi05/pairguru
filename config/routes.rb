Rails.application.routes.draw do
  mount ActionCable.server => "/cable"

  devise_for :users

  root "home#welcome"

  resources :genres, only: :index do
    member do
      get "movies"
    end
  end

  resources :movies, only: [:index, :show] do
    member do
      get :send_info
    end
    collection do
      get :export
    end
  end

  namespace :api do
    namespace :v1 do
      get "/movies", to: "movies#index"
      get "/movies/:id", to: "movies#show"
    end
  end
end
