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

  def is_correct_to_answer?
    case self.question.question_type
    when "text"
      return false if self.results_answers.first.nil?
      self.results_answers.first.answer_for_text == self.question.answers
        .first.content
    when "single_choice"
      answer = self.question.answers.detect{|answer| answer.is_correct?}
      self.answer_id == answer.id
    when "multiple_choice"
      answers = self.question.answers.find_all{|answer| answer.is_correct?}
      system_answers = answers.map{|answer| answer.id}
      user_answers = self.results_answers.map do
        |result_answer| result_answer.answer_id
      end
      (system_answers - user_answers).empty?
    end
  end
end
