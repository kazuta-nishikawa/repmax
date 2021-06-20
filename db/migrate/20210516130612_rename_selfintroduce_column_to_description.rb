# frozen_string_literal: true

class RenameSelfintroduceColumnToDescription < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :selfintroduce, :description
  end
end
