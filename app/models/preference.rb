class Preference < ActiveRecord::Base
  belongs_to :scout
  belongs_to :course

  validates :scout, :course, presence: true
  validates :course_id, uniqueness: { scope: :scout_id, 
    message: "Sorry, the scout already has this course preference" }
  validates :priority, uniqueness: { scope: :scout_id, 
    message: "Sorry, a preference with this priority already exists" }
end