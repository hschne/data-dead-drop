# frozen_string_literal: true

class CreateDiceWords < ActiveRecord::Migration[7.1]
  def change
    create_table :dice_words do |t|
      t.string :words

      t.timestamps
    end
  end
end
