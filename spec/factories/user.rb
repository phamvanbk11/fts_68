FactoryGirl.define do
  factory :user do
    name "Admin user"
    email "admin@gmail.com"
    password "password"
    password_confirmation "password"
    admin true
  end
end
