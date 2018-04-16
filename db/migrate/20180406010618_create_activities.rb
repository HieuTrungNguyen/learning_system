class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.integer :activity_type
      t.references :activityable, polymorphic: true, index: true
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
