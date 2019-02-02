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
    end
  end
end
