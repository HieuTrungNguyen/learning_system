class Result < ApplicationRecord
  belongs_to :lesson
  belongs_to :word
  belongs_to :answer

  QUERY = "INNER JOIN answers ON results.word_id = answers.word_id
    AND results.answer_id = answers.id"
  scope :correct, -> {joins(QUERY).merge(Answer.correct)}
end
