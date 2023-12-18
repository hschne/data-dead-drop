# frozen_string_literal: true

namespace :import do
  task dice_words: :environment do
    words = File.readlines('lib/assets/dice_words.txt', chomp: true).map do |line|
      /^(?<die_rolls>[123456]{5})\s+(?<words>.*)$/ =~ line
      { id: die_rolls, words: }
    end
    DiceWord.insert_all(words)
  end
end
