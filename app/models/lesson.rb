class Lesson < ApplicationRecord
  belongs_to :category
  belongs_to :user

  has_many :results, dependent: :destroy, inverse_of: :lesson
  delegate :name, to: :category, prefix: true
  before_create :words_create_lesson

  validate :verify_create_lesson

  accepts_nested_attributes_for :results,
    reject_if: proc{|attribute| attribute[:answer_id].blank?}

  private
  def words_for_lesson
    self.category.words.order("Random()").limit(Settings.lesson.size).each do |word|
      self.results.build word_id: word.id
    end
  end

  def verify_create_lesson
    if Settings.lesson.size > self.category.words.size
      self.errors.add :category, I18n.t("not_enough_word")
    end
  end
end
