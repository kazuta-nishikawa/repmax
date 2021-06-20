# frozen_string_literal: true

ActiveRecord::Schema.define(version: 20_210_528_140_802) do
  create_table 'physicals', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.float 'body_weight'
    t.float 'body_fat_ratio'
    t.date 'date'
    t.bigint 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[user_id date], name: 'only_one_data_per_a_day', unique: true
    t.index ['user_id'], name: 'index_physicals_on_user_id'
  end

  create_table 'records', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.date 'date'
    t.string 'workout'
    t.float 'weight'
    t.integer 'rep'
    t.bigint 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_records_on_user_id'
  end

  create_table 'users', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.string 'password_digest'
    t.date 'birthday'
    t.integer 'height'
    t.string 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'physicals', 'users'
  add_foreign_key 'records', 'users'
end
