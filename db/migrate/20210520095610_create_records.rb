# frozen_string_literal: true

class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.date :date
      t.string :workout
      t.float :weight
      t.integer :rep
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
