FactoryGirl.define do
  content = Faker::Lorem.word
  factory :question do
    content content
  end
end
