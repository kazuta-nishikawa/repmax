# frozen_string_literal: true

class Record < ApplicationRecord
  belongs_to :user

  validates :date, presence: true
  validates :workout, presence: true
  validates :weight, presence: true, numericality: { less_than: 500, greater_than: 0 }
  validates :rep, presence: true, numericality: { less_than: 500, greater_than: 0 }
end
