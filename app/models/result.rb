class Result < ActiveRecord::Base
  belongs_to :exam
  belongs_to :question
  belongs_to :answer
  scope :count_correct_answer, -> do
    joins(:answer).where(answers: {is_correct: true}).count
  end
end
