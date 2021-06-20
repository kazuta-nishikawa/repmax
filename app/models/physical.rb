# frozen_string_literal: true

class Physical < ApplicationRecord
  belongs_to :user

  validates :date, presence: true, uniqueness: { scope: :user_id }
  validates :body_weight, presence: true, numericality: true
  validates :body_fat_ratio, allow_nil: true, numericality: true
end
