# frozen_string_literal: true

class CreateDrops < ActiveRecord::Migration[7.1]
  def change
    create_table :drops do |t|
      t.string :path
      t.datetime :expiry
      t.integer :remaining_uses

      t.timestamps
    end
  end
end
