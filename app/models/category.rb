class Category < ApplicationRecord
  has_many :words
  has_many :lessons

  validates :name, presence: true, length: {maximum: 50},
    uniqueness: {case_sensitive: false}
  validates :description, presence: true, length: {maximum: 255}

  scope :all_categories, -> search {where QUERY_BY_NAME, search: "%#{search}%"}
  QUERY_BY_NAME = "name like :search"
end
