require 'rails_helper'

RSpec.describe CleanupJob do
  it 'does not delete uploads with remaining uses and expiry' do
    upload = create(:upload)

    described_class.perform_now

    expect(Upload.exists?(upload.id)).to be(true)
  end

  it 'deletes uploads with no remaining uses' do
    upload = create(:upload, uses: 0)

    described_class.perform_now

    expect(Upload.exists?(upload.id)).to be(false)
  end

  it 'deletes expired uploads' do
    upload = create(:upload, expiry: 1.minute.ago)

    described_class.perform_now

    expect(Upload.exists?(upload.id)).to be(false)
  end
end
