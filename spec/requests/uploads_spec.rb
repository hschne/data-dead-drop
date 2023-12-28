# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Uploads' do
  describe 'GET /new' do
    it 'returns successfully' do
      get '/new'

      expect(response).to be_successful
    end
  end

  describe 'POST /upload' do
    it 'redirects and uploads file' do
      post '/upload', params:
        {
          upload: {
            data: fixture_file_upload('sample.txt', 'text/plain')
          }
        }

      upload = Upload.last
      expect(upload.data).to be_attached
      expect(response).to redirect_to(preview_url(upload))
    end

    it 'renders unprocessable if error' do
      post '/upload', params:
        {
          upload: {
            data: nil
          }
        }

      expect(response).to be_unprocessable
    end

    context 'with json format' do
      it 'uploads file' do
        post '/upload', params:
          {
            upload: {
              data: fixture_file_upload('sample.txt', 'text/plain')
            }
          }, headers: { 'Accept' => 'application/json' }

        expect(response).to be_successful
        upload = Upload.last
        expect(upload.data).to be_attached
      end

      it 'renders response' do
        post '/upload', params:
          {
            upload: {
              data: fixture_file_upload('sample.txt', 'text/plain')
            }
          }, headers: { 'Accept' => 'application/json' }

        json = response.parsed_body
        expect(json['key']).not_to be_nil
        expect(json['expiry']).not_to be_nil
        expect(json['uses']).to be(1)
        expect(json['name']).to eq('sample.txt')
      end

      it 'renders unprocessable' do
        post '/upload', params:
          {
            upload: {
              data: nil
            }
          }, headers: { 'Accept' => 'application/json' }

        expect(response).to be_unprocessable
        json = response.parsed_body
        puts json
        expect(json['data']).to eq(["can't be blank"])
      end
    end

    describe 'GET /preview' do
      it 'previews existing upload' do
        upload = create(:upload)

        get preview_url(upload)

        expect(response).to be_successful
      end

      it 'renders json preview' do
        upload = create(:upload)

        get preview_url(upload), headers: { 'Accept' => 'application/json' }

        expect(response).to be_successful
        json = response.parsed_body
        expect(json['key']).not_to be_nil
        expect(json['expiry']).not_to be_nil
        expect(json['uses']).to be(1)
        expect(json['name']).to eq('sample.txt')
      end

      it 'renders 404 with already previewed' do
        upload = create(:upload, previewed: true)

        get preview_url(upload)

        expect(response).to be_not_found
      end

      it 'renders 404 with expired' do
        upload = create(:upload, expiry: 1.minute.ago)

        get preview_url(upload)

        expect(response).to be_not_found
      end

      it 'renders 404 with used' do
        upload = create(:upload, uses: 0)

        get preview_url(upload)

        expect(response).to be_not_found
      end
    end

    describe 'GET /download' do
      it 'redirects to existing upload' do
        upload = create(:upload)

        get download_url(upload)

        expect(response).to be_redirect
      end

      it 'decrements uses' do
        upload = create(:upload, uses: 2)

        get download_url(upload)

        upload.reload
        expect(upload.uses).to be(1)
      end

      it 'renders 404 with expired' do
        upload = create(:upload, expiry: 1.minute.ago)

        get download_url(upload)

        expect(response).to be_not_found
      end

      it 'renders 404 with used' do
        upload = create(:upload, uses: 0)

        get download_url(upload)

        expect(response).to be_not_found
      end
    end
  end
end
