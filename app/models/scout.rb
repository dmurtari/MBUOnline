class Scout < ActiveRecord::Base
  has_many :records
  has_many :courses, through: :records

  has_many :preferences
  has_many :preferred_courses, through: :preferences, source: :course, dependent: :destroy

  before_save :reformat_phone, :calculate_age, :calculate_costs

  belongs_to :user
  validates :user_id, :firstname, :lastname, :dob, :emergency_relation,
            :emergency_name, presence: true
            
  VALID_PHONE_REGEX = /\d{3}.*\d{3}.*\d{4}/
  validates :emergency_phone, presence: true, format: { with: VALID_PHONE_REGEX }

  def has_preference?(preferred_course)
    event = Event.where(current: true).last
    preferences.find_by(course_id: preferred_course.id, event_id: event.id)
  end

  def has_priority?(priority)
    event = Event.where(current: true).last
    preferences.find_by(priority: priority, event_id: event.id)
  end

  def add_preference!(preferred_course, priority)
    preferences.create!(course_id: preferred_course.id, priority: priority)
  end

  def add_record!(course, period)
    course.add_scout! period
    records.create!(course_id: course.id, period: period)
  end

  def has_record?(course)
    event = Event.where(current: true).last
    records.find_by(course_id: course.id, event_id: event.id)
  end

  def has_period?(period)
    event = Event.where(current: true).last
    records.find_by(period: period, event_id: event.id)
  end

  def remove_record!(course, period, event)
    course.remove_scout! period
    records.find_by(course_id: course.id, event_id: event.id).destroy
  end

  def remove_preference!(preferred_course)
    preferences.find_by(course_id: preferred_course.id).destroy
  end

  def calculate_costs
    cost = 15
    if self.scout_lunch
      cost += 7.00 if self.age <= 12
      cost += 9.50 if self.age > 12
    end

    cost += (self.additional_lunch * 9.50) if self.additional_lunch

    cost += 3 if self.patch
    cost += 8 if self.shirt

    self.records.each do |record|
      cost += record.course.price unless record.course.price.nil?
    end

    self.cost = cost
  end

  private
    def reformat_phone
      phone_match = /(\d{3}).*(\d{3}).*(\d{4})/.match(self.emergency_phone.to_s)
      self.emergency_phone = "(#{phone_match[1]}) #{phone_match[2]}-#{phone_match[3]}"
    end

    def calculate_age
      now = Time.now.utc.to_date
      self.age = now.year - self.dob.year - ((now.month > self.dob.month || 
        (now.month == self.dob.month && now.day >= self.dob.day)) ? 0 : 1)
    end
end
