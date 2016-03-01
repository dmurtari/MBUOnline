class Scout < ActiveRecord::Base
  has_many :records
  has_many :courses, through: :records

  has_many :preferences
  has_many :preferred_courses, through: :preferences, source: :course, dependent: :destroy

  before_save :reformat_phone, :calculate_age
  after_save :calculate_costs

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

  def preferences_for?(event)
    preferences.where(event: event).any?
  end

  def preferences_count(event)
    preferences.where(event:event).count
  end

  def records_for?(event)
    records.where(event: event).any?
  end

  def calculate_costs
    event = Event.where(current: true).last
    calculate_age

    if !preferences_for?(event) && !records_for?(event)
      update_columns(cost: 0)
    else
      cost = 0

      if preferences_count(event) >= 3
        cost += 18
      else
        cost += preferences_count(event) * 6
      end

      if self.scout_lunch && (self.age >  12 || self.age < 3)
        cost += 10.5
      elsif self.scout_lunch
        cost += 9
      end

      cost += (self.additional_lunch * 10.5) if self.additional_lunch
      cost += 10 if self.shirt

      self.records.where(event: event).each do |record|
        cost += record.course.price unless record.course.price.nil?
      end

      update_columns(cost: cost)
      self.user.calculate_total_cost
      cost
    end
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
