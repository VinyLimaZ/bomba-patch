# frozen_string_literal: true

Rails.application.routes.draw do
  default_url_options host: ENV.fetch('HOST_URL') { 'http://testing.io' }

  concern :api_base do
    resources :users
  end

  namespace :api do
    namespace :v1 do
      concerns :api_base
    end
  end
end
