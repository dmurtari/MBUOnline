require 'rails_helper'

RSpec.describe User, :type => :model do
  before do
    @user = User.new(firstname: "Foo", lastname: "Bar", email: "foobar@example.com",
                     phone: "555-123-4567", password: "Foobar42", 
                     password_confirmation: "Foobar42")
  end

  subject { @user }

  it { should respond_to(:firstname) }
  it { should respond_to(:lastname) }
  it { should respond_to(:email) }
  it { should respond_to(:phone) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }


  it { should be_valid }

  describe "when firstname is not present" do
    before { @user.firstname = " " }
    it { should_not be_valid }
  end

  describe "when lastname is not present" do
    before { @user.lastname = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when phone is not present" do
    before { @user.phone = " " }
    it { should_not be_valid }
  end

  describe "when firstname is too long" do
    before {@user.firstname = "a" * 41 }
    it { should_not be_valid}
  end

  describe "when lastname is too long" do
    before { @user.lastname = "a" * 41 }
    it { should_not be_valid}
  end
  
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    it { should_not be_valid }
  end

  describe "when password is too short" do
    before do
      @user.password = "hello"
      @user.password_confirmation = "hello"
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "Nomatch42" }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_falsey }
    end
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end
end
