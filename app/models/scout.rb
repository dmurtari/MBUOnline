class Scout < ActiveRecord::Base
  has_many :records
  has_many :preferences
  has_many :courses, through: :records
  has_many :preferred_courses, through: :preferences, source: :courses

  belongs_to :user
  validates :user_id, :firstname, :lastname, :dob, :emergency_relation,
            :emergency_name, :emergency_phone, presence: true

  def has_preference?(preferred_course)
    preferences.find_by(course_id: preferred_course.id)
  end

  def add_preference!(preferred_course)
    preferences.create!(course_id: preferred_course.id)
  end

  def remove_preference!(preferred_course)
    preferences.find_by(course_id: preferred_course.id).destroy
  end
end
