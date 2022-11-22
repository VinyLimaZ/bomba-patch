# frozen_string_literal: true

Rails.application.routes.draw do
  default_url_options host: ENV.fetch('HOST_URL') { 'http://testing.io' }

  concern :api_base do
    resources :users, only: %i[show create update destroy]
    resources :teams, only: %i[index show create update destroy]
    resources :matches, only: %i[index show create update destroy]
    post '/sign_in', to: 'authentication#create'
  end

  namespace :api do
    namespace :v1 do
      concerns :api_base
    end
  end

  resources :matches
end
