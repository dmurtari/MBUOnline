class Record < ActiveRecord::Base
  belongs_to :scout
  belongs_to :course
  belongs_to :event

  before_save :assign_event

  validates :scout, :course, presence: true
  validates :period, uniqueness: { scope: :scout_id,
    message: "Sorry, assignment for this period already exists"}

  def assign_event
    event = Event.where(current: true).last
    self.event = event
  end
  
end