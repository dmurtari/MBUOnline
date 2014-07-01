require 'rails_helper'

RSpec.describe "Users", :type => :request do
  subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.firstname) }
    it { should have_title("#{user.firstname} #{user.lastname}") }
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) } 

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "First Name", with: "Foo"
        fill_in "Last Name", with: "Bar"
        fill_in "Email", with: "foo@bar.com"
        fill_in "Phone Number", with: "555-555-5555"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Sign out') }
        it { should have_selector('.alert .alert-success') }
      end

      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_user_path(user) }

    describe "page" do
      it { should have_content("Update Profile") }
      it { should have_title(full_title("Update User")) }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }
      it { should have_content('error') }
    end
  end

end