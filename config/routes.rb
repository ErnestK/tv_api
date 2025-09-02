Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :contents, only: [:index]

      resources :movies, only: [:show]
      resources :tv_shows, only: [:show]
      resources :tv_shows_seasons, only: [:show]
      resources :tv_shows_seasons_episodes, only: [:show]
      resources :channels, only: [:show]
      resources :channel_programs, only: [:show]
      resources :provider_apps, only: [:show]

      # User-specific endpoints
      resources :users, only: [] do
        member do
          get :favorite_channel_programs
          get :favorite_provider_apps
          post :favorite_provider_app
        end
      end
    end
  end
end
