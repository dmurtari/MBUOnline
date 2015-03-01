class Preference < ActiveRecord::Base
  belongs_to :scout
  belongs_to :course
  belongs_to :event

  before_save :assign_event

  validates :scout, :course, presence: true
  validates :course_id, uniqueness: { scope: :scout_id, 
    message: "Sorry, the scout already has this course preference" }
  # validates :priority, uniqueness: { scope: :scout_id, 
  # message: "Sorry, a preference with this priority already exists" }

  def assign_event
    event = Event.where(current: true).last
    self.event = event
  end

end