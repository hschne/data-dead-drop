# frozen_string_literal: true

# == Schema Information
#
# Table name: uploads
#
#  id         :integer          not null, primary key
#  expiry     :datetime         not null
#  key        :string           not null
#  previewed  :boolean          default(FALSE), not null
#  uses       :integer          default(1), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_uploads_on_key  (key) UNIQUE
#
class Upload < ApplicationRecord
  has_one_attached :file

  validates :expiry, presence: true
  validates :key, presence: true
  validates :uses, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :file, attached: true, size: { less_than: 1024.kilobytes, message: 'must be smaller than 1 MB' } # rubocop:disable Rails/I18nLocaleTexts

  validate :expires_range, if: -> { expiry.present? }

  def minutes_left
    ((expiry - Time.zone.now) / 1.minute).to_i
  end

  def expires_range
    return if expiry < 61.minutes.from_now

    errors.add(:expiry, 'must be less than an hour')
  end

  def to_param
    key
  end

  def self.generate_key
    ids = (1..3).map { (1..5).map { rand(1..6) }.join.to_i }
    DiceWord
      .find(*ids)
      .map(&:words)
      .map(&:split)
      .map { |t| t[rand(0..t.length - 1)] }.flatten.join('-')
  end
end
