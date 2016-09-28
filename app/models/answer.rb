class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :results
  has_many :results_answers
  validates :content, presence: true, length: {maximum: 255}
end
