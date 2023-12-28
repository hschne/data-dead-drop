# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
def import_dicewords
  words = File.readlines('lib/assets/dice_words.txt', chomp: true).map do |line|
    /^(?<die_rolls>[123456]{5})\s+(?<words>.*)$/ =~ line
    { id: die_rolls, words: }
  end
  DiceWord.insert_all(words) # rubocop:disable Rails/SkipsModelValidations
end

import_dicewords unless DiceWord.any?
