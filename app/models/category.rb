class Category < ApplicationRecord
  has_many :word
  has_many :lessons
end
