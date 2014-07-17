class Scout < ActiveRecord::Base
  has_many :records
  has_many :preferences
  has_many :courses, through: :records
  has_many :preferred_courses, through: :preferences, source: :course

  before_save :reformat_phone

  belongs_to :user
  validates :user_id, :firstname, :lastname, :dob, :emergency_relation,
            :emergency_name, presence: true

  VALID_PHONE_REGEX = /\d{3}.*\d{3}.*\d{4}/
  validates :emergency_phone, presence: true, format: { with: VALID_PHONE_REGEX }

  def has_preference?(preferred_course)
    preferences.find_by(course_id: preferred_course.id)
  end

  def add_preference!(preferred_course)
    preferences.create!(course_id: preferred_course.id)
  end

  def remove_preference!(preferred_course)
    preferences.find_by(course_id: preferred_course.id).destroy
  end

  private

    def reformat_phone
      phone_match = /(\d{3}).*(\d{3}).*(\d{4})/.match(self.emergency_phone.to_s)
      self.emergency_phone = "(#{phone_match[1]}) #{phone_match[2]}-#{phone_match[3]}"
    end
end
