# frozen_string_literal: true

hosts = {
  development: 'localhost:3000',
  production: 'datadeaddrop.com'
}.freeze

Rails.application.routes.default_url_options[:host] = hosts[Rails.env.to_sym]
