class Scout < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :firstname, :lastname, :dob, :emergency_relation,
            :emergency_name, :emergency_phone, presence: true
end
