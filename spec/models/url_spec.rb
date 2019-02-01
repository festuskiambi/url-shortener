require 'rails_helper'

RSpec.describe Url, type: :model do
  it { should validate_presence_of(:original_url) }

  context '#generate_short_url' do
    it 'creates a six character short url including letters and numbers' do
      url = build(:url)
      url.generate_short_url
      expect(url.short_url).to match(/\A[a-z\d]{6}\z/i)
    end
  end
end
