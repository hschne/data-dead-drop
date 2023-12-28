# frozen_string_literal: true

hosts = {
  development: 'http://localhost:3000',
  test: 'http://localhost:3000',
  production: 'https://datadeaddrop.com'
}.freeze

Rails.application.routes.default_url_options[:host] = hosts[Rails.env.to_sym]
