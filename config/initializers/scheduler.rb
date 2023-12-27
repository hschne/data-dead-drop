# frozen_string_literal: true

require 'rufus-scheduler'

stop = defined?(Rails::Console) ||
       Rails.env.test? ||
       File.split($PROGRAM_NAME).last == 'rake'
return if stop

scheduler = Rufus::Scheduler.singleton

# Run cleanup job every minute
scheduler.cron '* * * * *' do
  CleanupJob.perform_later
end
