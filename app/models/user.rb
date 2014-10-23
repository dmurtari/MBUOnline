class User < ActiveRecord::Base

  has_many :scouts, dependent: :destroy

  # Actions to perform before saving to database
  before_save { email.downcase! }
  before_save :reformat_phone
  before_create :create_remember_token

  # Validations on new user creation
  validates :firstname, :lastname, presence: true
  validates :firstname, :lastname, length: {
    maximum: 40,
    too_long: "First or last name cannot be more than 40 characters"
  }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, 
            format: { with: VALID_EMAIL_REGEX }

  VALID_PHONE_REGEX = /\d{3}.*\d{3}.*\d{4}/
  validates :phone, presence: true, format: { with: VALID_PHONE_REGEX }

  # Password for users
  has_secure_password 
  validates :password, length: { minimum: 6 }, on: :create
  validates :password_confirmation, presence: true, on: :update,
            :unless => lambda{ |user| user.password.blank? }


  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def calculate_total_cost
    total_cost = 0

    self.scouts.each do |scout|
      total_cost += scout.cost unless scout.cost.nil?
    end

    self.total_cost = total_cost
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end

    def reformat_phone
      phone_match = /(\d{3}).*(\d{3}).*(\d{4})/.match(self.phone.to_s)
      self.phone = "(#{phone_match[1]}) #{phone_match[2]}-#{phone_match[3]}"
    end

end
