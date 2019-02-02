require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  let(:user) { create(:user) }
  #mock authorization header
  let(:header) { { 'Authorization' => token_generator(user.id) }}
  # Invalid request subject
  subject(:invalid_request_obj) { described_class.new({}) }
  #valid request subject
  subject(:request_obj) { described_class.new(header) }

  describe '#call' do
    #returns the user object when request is valid
    context 'when request is valid' do
      it 'returns the user object' do
        result = request_obj.call
        expect(result[:user]).to eq(user)
      end
    end

    context 'when request is invalid' do
      context 'when token is missing' do
        it 'raises MissingtokenError' do
          expect { invalid_request_obj.call }
            .to raise_error(ExceptionHandler::MissingToken, 'Missing token')
        end
      end

      context 'when token is invalid' do
        subject(:invalid_request_obj) do
          described_class.new('Authorization' => token_generator(5))
        end

        it 'raises InvalidToken error' do
          expect { invalid_request_obj.call }
            .to raise_error(ExceptionHandler::InvalidToken, /Invalid token/)
        end
      end

      context 'when token is expired' do
        let(:header) { { 'Authorization' => expired_token_generator(user.id)}}
        subject(:request_obj) { described_class.new(header) }

        it 'raises ExpiredSignature error' do
          expect { request_obj.call }
            .to raise_error(
              ExceptionHandler::InvalidToken,
              /Signature has expired/
            )
        end
      end

      context 'when token is fake' do
        let(:header) { {'Authorization' => 'foobar'} }
        subject(:invalid_request_obj) { described_class.new(header)}

        it 'handles JWT::Decodeerror' do
          expect{ invalid_request_obj.call }
            .to raise_error(
              ExceptionHandler::InvalidToken,
              /Not enough or too many segments/
            )
        end
      end
    end
  end
end
