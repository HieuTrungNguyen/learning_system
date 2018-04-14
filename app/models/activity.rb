class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :activityable, polymorphic: true

  enum action: {follow: 1, unllow: 2, start_lesson: 3, finish_lesson: 4}
end
