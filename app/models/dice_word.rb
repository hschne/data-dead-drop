# frozen_string_literal: true

# == Schema Information
#
# Table name: dice_words
#
#  id         :integer          not null, primary key
#  words      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class DiceWord < ApplicationRecord
  def readonly?
    true
  end

  class << self
    def generate_password
      ids = (1..4).map { (1..5).map { rand(1..6) }.join.to_i }
      DiceWord
        .find(*ids)
        .map(&:words)
        .map { |w| w.split(' ') }
        .map { |t| t[rand(0..t.length - 1)] }.flatten.join('-')
    end
  end
end
