class Course < ActiveRecord::Base
  has_many :records
  has_many :scouts, through: :records

  has_many :preferences, dependent: :destroy
  has_many :requesting_scouts, through: :preferences, source: :scout
  
  validates :room, presence: true
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :capacity, presence: true

  before_save :initialize_capacities

  def has_room?(period)
    case period
    when 1
      first_period < capacity
    when 2
      second_period < capacity
    when 3
      third_period < capacity
    end
  end

  def add_scout(period)
    case period
    when 1 
      first_period += 1
    when 2
      second_period += 1
    when 3
      third_period += 1
    end
  end

  private

    def initialize_capacities
      first_period ||= 0
      second_period ||= 0
      third_period ||= 0
    end
end
