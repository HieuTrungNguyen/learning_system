class Word < ApplicationRecord
  belongs_to :category

  has_many :answers, dependent: :destroy, inverse_of: :word
  has_many :results

  delegate :name, to: :category, prefix: true

  validates :content, presence: true, length: {maximum: 50},
    uniqueness: {case_sensitive: false}

  scope :all_words, -> user_id, search {where QUERY_BY_CONTENT, search: "%#{search}%"}
  scope :learnt, -> user_id, search {where QUERY_LEARNT, user_id: user_id,
    search: "%#{search}%"}
  scope :not_learnt, -> user_id, search {where QUERY_NOT_LEARNT, user_id: user_id,
    search: "%#{search}%"}
  scope :in_category, -> category_id do
    where category_id: category_id if category_id.present?
  end

  QUERY_BY_CONTENT = "content like :search"
  QUERY_LEARNT = "content like :search AND id IN(
    SELECT word_id FROM results r INNER JOIN lessons l ON r.lesson_id = l.id
     WHERE l.user_id = :user_id)"
  QUERY_NOT_LEARNT = "content like :search AND id NOT IN(
    SELECT word_id FROM results r INNER JOIN lessons l ON r.lesson_id = l.id
     WHERE l.user_id = :user_id)"

  accepts_nested_attributes_for :answers, allow_destroy: true,
    reject_if: proc{|attributes| attributes["content"].blank?}

  validate :check_answers

  class << self

    def list_words
      self.order(created_at: :ASC).includes(:category)
    end

    def import
      CSV.foreach(file.path, headers: true, col_sep: "|", header_converters: :symbol) do |row|
        row = row.to_hash
        answers_attributes = []
        row[:answers].split(";").each do |answer|
          answer_hash = Hash.new
          arr_answer = answer.split(",")
          answer_hash[:content] = arr_answer[0]
          answer_hash[:is_correct] = arr_answer[1]
          answers_attributes.push answer_hash
        end
        row[:answers_attributes] = answers_attributes
        row.delete :answers
        Word.create! row
      end
    end

    def export
      attributes = %w{id content category_id}
      CSV.generate do |csv|
        csv << attributes
        all.each do |item|
          csv << attributes.map{|attr| item.send(attr)}
        end
      end
    end
  end

  private
  def check_answers
    size_correct = self.answers.select{|answer| answer.is_correct}.size
    if size_correct == 0
      errors.add I18n.t("validate.answer"), I18n.t("validate.zero")
    end
    if size_correct > 1
      errors.add I18n.t("validate.answer"), I18n.t(".required_1_correct")
    end
    if answers.length > answers.group_by { |a| a[:content] }.length
      self.errors.add :answers, I18n.t("validate.duplication")
    end
  end
end
