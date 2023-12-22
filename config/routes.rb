# frozen_string_literal: true

Rails.application.routes.draw do
  get 'errors/not_found'
  get 'errors/internal_server_error'
  root 'application#home'

  get '/legal', to: 'application#legal', as: :legal

  get '/n', to: 'uploads#new', as: :new
  post '/u', to: 'uploads#upload', as: :upload
  get '/p/:id', to: 'uploads#preview', as: :preview
  get '/d/:id', to: 'uploads#download', as: :download
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Preview error pages
  get '/errors/404', to: 'errors#not_found'
  get '/errors/500', to: 'errors#internal_server_error'

  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  if Rails.application.config.active_storage.service == :local
    scope ActiveStorage.routes_prefix do
      get '/disk/:encoded_key/*filename' => 'active_storage/disk#show', as: :rails_disk_service
      put '/disk/:encoded_token' => 'active_storage/disk#update', as: :update_rails_disk_service
    end
  end
end
