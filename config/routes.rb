# coding: utf-8
Rails.application.routes.draw do
  scope module: 'apress/videos', constraints: {domain: :current} do
    namespace :api, defaults: {format: :json} do
      current_api_routes = lambda do
        resources :videos, only: :show
      end

      scope module: :v1, &current_api_routes
      namespace :v1, &current_api_routes
    end
  end
end
