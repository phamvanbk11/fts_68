class Question < ActiveRecord::Base
  belongs_to :subject
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :results
  has_many :exams, through: :results
  enum question_type: [:single_choice, :multiple_choice, :text]
  enum state: [:waiting, :rejected, :active, :inactive]
  validates :content, presence: true, length: {maximum: 255}

  scope :unlearned, -> do
    where subject_id: Subject.joins(:exams, :questions)
      .where.not(exams: {is_finished: true}).distinct
  end
  scope :randomize, ->(word_per_page) do
    order("RANDOM()").limit word_per_page
  end

  def correct_answer
    answer = answers.detect {|answer| answer.is_correct?}
    answer.content
  end

  def valid_to_delete?
    !self.exams.any?
  end

end
