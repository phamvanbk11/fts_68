class Exam < ActiveRecord::Base
  after_create :create_answer_for_specify_exam, :set_default
  enum state: [:start, :testing, :uncheck, :checked]

  belongs_to :subject
  belongs_to :user
  has_many :results, dependent: :destroy
  has_many :questions, through: :results
  accepts_nested_attributes_for :results

  scope :desc, -> {order(created_at: :desc)}

  def set_time_and_status
    self.testing!
    self.update_attributes start_tested_at: Time.now()
  end

  def set_uncheck_status
    spent_time = Time.now - self.start_tested_at
    self.uncheck!
    self.update_attributes is_finished: true, spent_time: spent_time
  end

  def update_spent_time
    spent_time = Time.now - self.start_tested_at
    self.update_attributes spent_time: spent_time
  end

  def time_left
    spent_time = Time.now - self.start_tested_at
    time_left = self.subject.duration.minutes - spent_time
    if time_left > 0
      time_left
    else
      self.subject.duration.minutes
    end
  end

  def number_of_correct
    self.results.find_all{|result| result.is_correct_to_answer?}.size
  end

  private
  def create_answer_for_specify_exam
    @questions = Question.by_subject(self.subject)
      .randomize self.subject.number_of_questions
    @questions.each do |question|
      self.results.build question_id: question.id
    end
  end

  def set_default
    self.start!
  end
end
