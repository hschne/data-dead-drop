# frozen_string_literal: true

json.extract! upload, :key, :expiry, :remaining_uses, :created_at
json.url Rails.application.routes.url_helpers.download_url(upload)
json.name upload.data.filename.to_s
