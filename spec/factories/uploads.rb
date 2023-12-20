FactoryBot.define do
  factory :upload do
    sequence(:key) { |i| "random-key-#{i}" }
    expiry { 10.minutes.from_now }
    remaining_uses { 1 }
    data { Rack::Test::UploadedFile.new('spec/fixtures/files/sample.txt', 'image/png') }
  end
end
