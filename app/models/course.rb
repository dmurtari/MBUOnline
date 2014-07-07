class Course < ActiveRecord::Base
  validates :room, presence: true
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
