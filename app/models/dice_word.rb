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
end
