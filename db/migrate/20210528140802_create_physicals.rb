# frozen_string_literal: true

class CreatePhysicals < ActiveRecord::Migration[5.2]
  def change
    create_table :physicals do |t|
      t.float :body_weight
      t.float :body_fat_ratio
      t.date :date
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :physicals, %i[user_id date], unique: true, name: 'only_one_data_per_a_day'
  end
end
