class Record < ActiveRecord::Base
  belongs_to :scout
  belongs_to :course
  belongs_to :event

  validates :scout, :course, presence: true
  validates :period, uniqueness: { scope: :scout_id,
    message: "Sorry, assignment for this period already exists"}
end