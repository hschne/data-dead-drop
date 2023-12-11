# frozen_string_literal: true

class Drop < ApplicationRecord
  has_one_attached :data
end
