# frozen_string_literal: true

class Upload < ApplicationRecord
  has_one_attached :data
end
