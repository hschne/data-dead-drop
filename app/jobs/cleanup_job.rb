# frozen_string_literal: true

class CleanupJob < ApplicationJob
  queue_as :default

  def perform
    Upload.where(expiry: (..Time.zone.now))
      .or(Upload.where('uses < ?', 1))
      .destroy_all
  end
end
