require 'rails_helper'

RSpec.describe 'Url', type: :request do
 
  describe 'POST/ urls' do
    let(:valid_attributes) { { original_url: 'http://example.com' } }
   
    context 'when the request is valid' do
      before { post '/urls', params: valid_attributes }

      it "creates a shorted url " do
        expect(json['original_url']).to eq('http://example.com')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/urls', params: { short_url: 'btly'} }

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Original url can't be blank/)
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

    end
  end

end