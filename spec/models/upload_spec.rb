# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Upload do
  let(:large_file) do
    mebibyte_chunk = 'X' * 1_048_576
    tmp_file = Tempfile.new('2MB.txt')
    2.times { tmp_file.write(mebibyte_chunk) }
    tmp_file.close

    tmp_file
  end

  it 'is valid with valid attributes' do
    upload = build(:upload)

    expect(upload).to be_valid
  end

  it 'is not valid without a key' do
    upload = build(:upload, key: nil)

    expect(upload).not_to be_valid
  end

  it 'is not valid without expiry' do
    upload = build(:upload, expiry: nil)

    expect(upload).not_to be_valid
  end

  it 'is not valid with high expiry' do
    upload = build(:upload, expiry: 70.minutes.from_now)

    expect(upload).not_to be_valid
  end

  it 'is not valid without uses' do
    upload = build(:upload, uses: nil)

    expect(upload).not_to be_valid
  end

  it 'is not valid with high uses' do
    upload = build(:upload, uses: 6)

    expect(upload).not_to be_valid
  end

  it 'is not valid with negative uses' do
    upload = build(:upload, uses: -1)

    expect(upload).not_to be_valid
  end

  it 'is not valid without file' do
    upload = build(:upload, file: nil)

    expect(upload).not_to be_valid
  end

  it 'is not valid with large file' do
    file = Rack::Test::UploadedFile.new(large_file.path, 'text/plain')
    upload = build(:upload, file:)

    expect(upload).not_to be_valid
  end
end
