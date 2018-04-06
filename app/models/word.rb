class Word < ApplicationRecord
  belongs_to :category

  has_many :answers, dependent: :destroy, inverse_of: :word
  has_many :results

  validates :content, presence: true, length: {maximum: 50}

  accepts_nested_attributes_for :answers, allow_destroy: true,
    reject_if: proc{|attributes| attributes["content"].blank?}

  class << self
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
end
