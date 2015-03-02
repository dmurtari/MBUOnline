class Event < ActiveRecord::Base
  has_many :preferences
  has_many :records

  validates :year, :semester, presence: true
end
