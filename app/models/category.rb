class Category < ApplicationRecord
  has_many :word
  has_many :lessons

  validates :name, presence: true, length: {maximum: 50},
    uniqueness: {case_sensitive: false}
  validates :description, presence: true, length: {maximum: 255}
end
