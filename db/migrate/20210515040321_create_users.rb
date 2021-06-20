# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.date :birthday
      t.integer :height
      t.string :selfintroduce # カラム名をdescriptionに変更済み

      t.timestamps
    end
  end
end
