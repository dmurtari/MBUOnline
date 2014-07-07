class Course < ActiveRecord::Base
  validates :name, :room, presence: true
end
