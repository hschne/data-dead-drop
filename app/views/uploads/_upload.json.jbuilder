# frozen_string_literal: true

json.extract! upload, :key, :expiry, :uses, :created_at
json.url Rails.application.routes.url_helpers.download_url(upload)
json.name upload.file.filename.to_s
