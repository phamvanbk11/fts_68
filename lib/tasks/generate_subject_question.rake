task generate_subject_question: :environment do
  # Subjects
  30.times do
    name  = Faker::Name.name
    description = Faker::Lorem.sentence
    Subject.create! name: name, description: description,
      duration: 60, number_of_questions: 5
  end

  # Questions
  subjects = Subject.order(:created_at).take 20

  10.times do
    content = Faker::Lorem.word
    subjects.each do |subject|
      right_answer = rand(0..2)
      question = Question.new content: content,
        subject: subject, state: :active, question_type: :single_choice
      3.times do |i|
        answer = Answer.new content: content, is_correct: i == right_answer
        question.answers << answer
      end
      question.save
    end
  end
end
