# frozen_string_literal: true

# == Schema Information
#
# Table name: uploads
#
#  id             :integer          not null, primary key
#  expiry         :datetime         not null
#  key            :string           not null
#  previewed      :boolean          default(FALSE), not null
#  remaining_uses :integer          default(1), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_uploads_on_key  (key) UNIQUE
#
class Upload < ApplicationRecord
  has_one_attached :data

  validates :data, attached: true, size: { less_than: 512.kilobytes, message: 'is must be smaller than 512 kb' }

  def url; end

  def to_param
    key
  end

  def self.generate_key
    ids = (1..3).map { (1..5).map { rand(1..6) }.join.to_i }
    DiceWord
      .find(*ids)
      .map(&:words)
      .map { |w| w.split(' ') }
      .map { |t| t[rand(0..t.length - 1)] }.flatten.join('-')
  end
end
