# frozen_string_literal: true

json.extract! upload, :id, :path, :data, :expiry, :remaining_uses, :previewed, :created_at, :updated_at
json.url upload_url(upload, format: :json)
json.data url_for(upload.data)
