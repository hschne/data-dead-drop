# frozen_string_literal: true

json.extract! drop, :id, :path, :data, :expiry, :remaining_uses, :created_at, :updated_at
json.url drop_url(drop, format: :json)
json.data url_for(drop.data)
