FactoryGirl.define do
  name  = Faker::Name.name
  description = Faker::Lorem.sentence
  factory :subject do
    name name
    description description
    duration "20"
    number_of_questions Settings.question_per_exam
  end
end
