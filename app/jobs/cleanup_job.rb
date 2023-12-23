class CleanupJob < ApplicationJob
  queue_as :default

  def perform
    Upload.where(expiry: (..Time.now))
      .or(Upload.where('uses < ?', 1))
      .destroy_all
  end
end
