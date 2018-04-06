class Answer < ApplicationRecord
  belongs_to :word

  has_many :results

  validates :content, presence: true, length: {maximum: 50}
end
