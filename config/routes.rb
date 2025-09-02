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
    end
  end
end
