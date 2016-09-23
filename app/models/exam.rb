class Exam < ActiveRecord::Base
  belongs_to :subject
  belongs_to :user
  has_many :results, dependent: :destroy
  has_many :questions, through: :results

  after_create :create_answer_for_specify_exam, :set_default

  enum state: [:start, :testing, :uncheck, :checked]

  private
  def create_answer_for_specify_exam
    @questions = Question.unlearned.randomize Settings.question_per_exam
    @questions.each do |question|
      self.results.build question_id: question.id
    end
  end

  def set_default
    self.start!
  end
end
