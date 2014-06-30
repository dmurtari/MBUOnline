require 'rails_helper'

RSpec.describe "users/index", :type => :view do
  before(:each) do
    assign(:users, [
      User.create!(
        :firstname => "Firstname",
        :lastname => "Lastname",
        :troop => 1,
        :district => "Distric",
        :phone => "Phone",
        :email => "hello@email.com",
        :password => "testpass",
        :password_confirmation => "testpass"
      ),
      User.create!(
        :firstname => "Firstname",
        :lastname => "Lastname",
        :troop => 2,
        :district => "District",
        :phone => "Phone",
        :email => "hello2@gmail.com",
        :password => "testpass",
        :password_confirmation => "testpass"
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => "Firstname".to_s, :count => 2
    assert_select "tr>td", :text => "Lastname".to_s, :count => 2
    assert_select "tr>td", :text => "Troop".to_s, :count => 2
    assert_select "tr>td", :text => "District".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
  end
end
