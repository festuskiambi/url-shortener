require 'rails_helper'

RSpec.describe 'Url API', type: :request do
  let(:user) { create(:user) }
  let(:headers) { valid_headers }
 
  describe 'POST/ urls' do
    let(:valid_attributes) do
      {
        original_url: 'http://example.com',
        created_by: user.id.to_s
      }.to_json
    end

    let(:invalid_attributes) do
      {
        original_url: nil,
        created_by: user.id.to_s
      }.to_json
    end

    context 'when the request is valid' do
      before { post '/urls', params: valid_attributes, headers: headers }

      it 'creates a shorted url ' do
        expect(json['short_url']).to match(/\A[a-z\d]{6}\z/i)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/urls', params: invalid_attributes, headers: headers }

      it 'returns a validation failure message' do
        expect(json['message'])
          .to match(/Validation failed: Original url can't be blank/)
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

    end
  end

  describe 'GET urls/:short_url' do
    let!(:urls) { create_list(:url, 10) }

    before { get "/urls/#{short_url}",params: {}, headers: headers }
    context 'when record is found' do
      let(:short_url) { urls.first.short_url }

      it 'gets the url' do
        expect(json).not_to be_empty
        expect(json['short_url']).to eq(short_url)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when record deoes not exist' do
      let(:short_url) { 'dgfhjkk' }

      it 'returns nil' do
        expect(json).to be nil
      end
      
    end
  end

end