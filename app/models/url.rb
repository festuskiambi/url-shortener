class Url < ApplicationRecord
  validates_presence_of :original_url
  before_create :generate_short_url

  def generate_short_url
    chars = ['0'..'9', 'A'..'Z', 'a'..'z'].map{|range| range.to_a}.flatten
    self.short_url = 6.times.map{chars.sample}.join
  end
end
