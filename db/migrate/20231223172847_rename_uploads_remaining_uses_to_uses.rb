# frozen_string_literal: true

class RenameUploadsRemainingUsesToUses < ActiveRecord::Migration[7.1]
  def change
    rename_column :uploads, :remaining_uses, :uses
  end
end
