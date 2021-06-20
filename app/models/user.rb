# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true, length: { maximum: 50 }
  before_save { email.downcase! }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }

  has_many :records
  has_many :physicals
end
