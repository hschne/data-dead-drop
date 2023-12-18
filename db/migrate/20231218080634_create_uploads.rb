# frozen_string_literal: true

class CreateUploads < ActiveRecord::Migration[7.1]
  def change
    create_table :uploads do |t|
      t.string :path
      t.datetime :expiry
      t.integer :remaining_uses
      t.boolean :previewed

      t.timestamps
    end
  end
end
