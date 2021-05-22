class Record < ApplicationRecord
  belongs_to :user
  
  validates :weight, presence: true
  validates :rep, presence: true
  validates :date, presence: true
  validates :workout, presence: true
  
end
