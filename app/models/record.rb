class Record < ActiveRecord::Base
  belongs_to :scout
  belongs_to :course
end