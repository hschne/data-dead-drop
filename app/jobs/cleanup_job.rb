class CleanupJob < ApplicationJob
  queue_as :default

  def perform
    Upload.where(expiry: (Time.now..))
          .or(Upload.where('remaining_uses < ?', 1))
          .destroy_all
  end
end
