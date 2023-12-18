# frozen_string_literal: true

class CreateUploads < ActiveRecord::Migration[7.1]
  def change
    create_table :uploads do |t|
      t.string :key, null: false
      t.datetime :expiry, null: false
      t.integer :remaining_uses, null: false, default: 1
      t.boolean :previewed, null: false, default: 0

      t.timestamps
      t.index :key, unique: true
    end
  end
end
