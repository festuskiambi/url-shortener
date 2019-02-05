require 'rails_helper'

RSpec.describe 'Users Api' do
  let(:user) { create(:user) }
  let(:headers) { valid_headers.except('Authorization') }
  let(:valid_attributes) do
    attributes_for(:user, password_confirmation: user.password)
  end
  describe 'POST /signup' do    
    context 'when request is valid' do
      before { post '/signup', params: valid_attributes.to_json,headers: headers}

      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns a success mesage' do
        expect(json['message']).to match(/Account created successfully/)
      end
    end

    context 'when request is invalid' do
      before { post '/signup', params: {}, headers: headers }

      it 'returns a failure message' do
        expect(json['message']).to match(
          /Validation failed: Password can't be blank, Name can't be blank, Email can't be blank, Password digest can't be blank/
        )
      end

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end
    end
  end
end
