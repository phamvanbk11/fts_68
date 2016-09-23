class Question < ActiveRecord::Base
  belongs_to :subject
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :results
  has_many :exams, through: :results

  scope :unlearned, -> do
    where subject_id: Subject.joins(:exams, :questions)
      .where.not(exams: {is_finished: true}).distinct
  end

  scope :randomize, ->(word_per_page) do
    order("RANDOM()").limit word_per_page
  end
end
