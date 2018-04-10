module ApplicationHelper
  def full_title page_title
    base_title = t ".title"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def index_for counter, page, per_page
    (page - 1) * per_page + 1 + counter
  end

  def create_answer_index index
    (index + 65).chr + "."
  end

  def convert_datetime date
    date.to_formatted_s :long
  end
end
