class Result < ActiveRecord::Base
  belongs_to :exam
  belongs_to :question
  belongs_to :answer
  has_many :results_answers
  accepts_nested_attributes_for :results_answers, allow_destroy: true
  scope :count_correct_answer, -> do
    joins(:answer).where(answers: {is_correct: true}).count
  end

  def build_result_answer
    if question.multiple_choice?
      question.answers.each do |answer|
        unless ResultsAnswer.exists? answer_id: answer.id
          self.results_answers.build answer_id: answer.id
        end
      end
    else
      self.results_answers.build if self.results_answers.empty?
    end
  end
end
