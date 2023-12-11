# frozen_string_literal: true

# == Schema Information
#
# Table name: drops
#
#  id             :integer          not null, primary key
#  expiry         :datetime
#  path           :string
#  remaining_uses :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Drop < ApplicationRecord
  has_one_attached :data
end
