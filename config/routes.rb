# frozen_string_literal: true

Rails.application.routes.draw do
  root 'application#home'

  get '/legal', to: 'application#legal'

  get '/new', to: 'uploads#new', as: :new
  post '/upload', to: 'uploads#upload', as: :upload
  get '/preview/:id', to: 'uploads#preview', as: :preview
  get '/download/:id', to: 'uploads#download', as: :download
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
