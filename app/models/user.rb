class User < ActiveRecord::Base

  # Actions to perform before saving to database
  before_save { email.downcase! }

  # Validations on new user creation
  validates :firstname, :lastname, :phone, presence: true
  validates :firstname, :lastname, length: {
    maximum: 40,
    too_long: "First or last name cannot be more than 40 characters"
  }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, 
            format: { with: VALID_EMAIL_REGEX }

  # Password for users
  has_secure_password 
  validates :password, length: { minimum: 6 }

end
