# frozen_string_literal: true

Rails.application.routes.draw do
  get 'errors/not_found'
  get 'errors/internal_server_error'
  root 'application#home'

  get '/new', to: 'uploads#new', as: :new
  post '/upload', to: 'uploads#upload', as: :upload
  get '/download/:id/preview', to: 'uploads#preview', as: :preview
  get '/download/:id', to: 'uploads#download', as: :download
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Preview error pages
  get '/errors/404', to: 'errors#not_found'
  get '/errors/500', to: 'errors#internal_server_error'

  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
end
