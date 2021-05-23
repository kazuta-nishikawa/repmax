class Record < ApplicationRecord
  belongs_to :user
  
  validates :date, presence: true
  validates :workout, presence: true
  validates :bodyweight,numericality: { less_than: 500, greater_than:0 }
  validates :weight, presence: true,numericality: { less_than: 500, greater_than:0 }
  validates :rep, presence: true,numericality: { less_than: 500, greater_than:0 }
  
  

    
end
