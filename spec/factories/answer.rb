FactoryGirl.define do
  content = Faker::Lorem.word
  factory :answer do
    content content
  end
end
