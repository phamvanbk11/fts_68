task generate_exam: :environment do
  subjects = Subject.order(:created_at).take 2
  subjects.each do |subject|
    user = User.find_by(email: "user@gmail.com")
    exam = Exam.new user: user, subject: subject
    exam.save
    quesions = subject.questions.take 2
    quesions.each do |question|
      result = Result.new question: question, exam: exam,
        answer: question.answers.first
      result.save
    end
  end
end
