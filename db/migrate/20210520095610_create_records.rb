class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.date :date
      t.integer :bodyweight
      t.string :workout
      t.integer :weight
      t.integer :rep
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
