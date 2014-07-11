class Scout < ActiveRecord::Base
  has_many :records
  has_many :preferences
  has_many :courses, through: :records
  has_many :courses, through: :preferences

  belongs_to :user
  validates :user_id, :firstname, :lastname, :dob, :emergency_relation,
            :emergency_name, :emergency_phone, presence: true

  def add_course!(course)
    records
end
