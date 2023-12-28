# frozen_string_literal: true

# == Schema Information
#
# Table name: uploads
#
#  id         :integer          not null, primary key
#  expiry     :datetime         not null
#  key        :string           not null
#  previewed  :boolean          default(FALSE), not null
#  uses       :integer          default(1), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_uploads_on_key  (key) UNIQUE
#
FactoryBot.define do
  factory :upload do
    sequence(:key) { |i| "random-key-#{i}" }
    expiry { 10.minutes.from_now }
    uses { 1 }
    file { Rack::Test::UploadedFile.new('spec/fixtures/files/sample.txt', 'text/plain') }
  end
end
