FactoryGirl.define do
  factory :user do
    firstname "Foo"
    lastname "Bar"
    email "foo@bar.com"
    phone "555-333-1111"
    password "Helloworld"
    password_confirmation "Helloworld"
  end
end