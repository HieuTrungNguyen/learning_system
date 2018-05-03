class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :activityable, polymorphic: true

  enum action: {follow: 1, unllow: 2, start_lesson: 3, finish_lesson: 4}

  scope :user_activity, -> user_id {where("user_id = ?", user_id)
    .order(created_at: :DESC)}

  def target_object
    case self.activity_type
    when Activity.actions[:follow]
      User.find_by id: self.activityable_id
    when Activity.actions[:unfollow]
      User.find_by id: self.activityable_id
    when Activity.actions[:start_lesson]
      Lesson.find_by id: self.activityable_id
    when Activity.actions[:finish_lesson]
      Lesson.find_by id: self.activityable_id
    end
  end
end
