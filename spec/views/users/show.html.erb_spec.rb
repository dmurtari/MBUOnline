require 'rails_helper'

RSpec.describe "users/show", :type => :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :firstname => "Firstname",
      :lastname => "Lastname",
      :troop => 1,
      :district => "District",
      :phone => "Phone",
      :email => "hello2@gmail.com",
      :password => "testpass",
      :password_confirmation => "testpass"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Firstname/)
    expect(rendered).to match(/Lastname/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/District/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Email/)
  end
end
