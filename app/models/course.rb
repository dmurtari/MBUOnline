class Course < ActiveRecord::Base
  has_many :records
  has_many :scouts, through: :records
  
  validates :room, presence: true
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
