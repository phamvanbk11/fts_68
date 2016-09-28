require "factory_girl_rails"
namespace :my_namespace do
  desc "TODO"
  task create_subjects: :environment do
    10.times do
      FactoryGirl.create(:subject)
    end
  end

  desc "TODO"
  task create_questions: :environment do
    subjects = Subject.order(:created_at).take 20
    30.times do
      content = Faker::Lorem.word
      subjects.each do |subject|
        right_answer = rand(0..Settings.answers_num_default-1)
        question = Question.new content: content, subject: subject
        Settings.answers_num_default.times do |i|
          answer = Answer.new content: content, is_correct: i == right_answer
          question.answers << answer
        end
        question.save
      end
    end
  end

  desc "TODO"
  task create_users: :environment do
    FactoryGirl.create(:user)
    10.times do |n|
      FactoryGirl.create :user, name:"user#{n}",
        email: "user#{n}@gmail.com", admin:false
    end
  end
end
