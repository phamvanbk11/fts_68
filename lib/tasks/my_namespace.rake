namespace :my_namespace do
  desc "TODO"
  task create_subjects: :environment do
    #Subject
    10.times do
      name  = Faker::Name.name
      description = Faker::Lorem.sentence
      Subject.create! name: name, description: description, duration: 20, number_of_questions: Settings.question_per_exam
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
  task create_user: :environment do
    User.create! name: "Admin User",
             email: "admin@gmail.com",
             password: "password",
             password_confirmation: "password",
             admin: true
    User.create! name: "User",
                 email: "user@gmail.com",
                 password: "password",
                 password_confirmation: "password"
    10.times do |n|
      name  = Faker::Name.name
      email = "Test-#{n+1}@gmail.com"
      password = "password"
      User.create! name:  name,
                   email: email,
                   password: password,
                   password_confirmation: password
    end
  end
end
