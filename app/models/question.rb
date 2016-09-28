class Question < ActiveRecord::Base
  belongs_to :subject
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :results
  has_many :exams, through: :results
  enum question_type: [:single_choice, :multiple_choice, :text]
  enum state: [:waiting, :rejected, :active, :inactive]
  validates :content, presence: true, length: {maximum: 255}
  validate :validate_answers, if: :validate_question_type?
  accepts_nested_attributes_for :answers, allow_destroy: true

  scope :updated_desc, -> {order updated_at: :desc}
  scope :sort_by_subject, -> {joins(:subject).order("subjects.name")}
  scope :by_subject, ->(subject) do
    where(subject_id: subject.id).distinct
  end
  scope :randomize, ->(word_per_page) do
    order("RANDOM()").limit word_per_page
  end
  scope :suggested, ->(user) do
    where(user: user, state: [states[:waiting], states[:rejected]])
  end

  def correct_answer
    answer = answers.detect {|answer| answer.is_correct?}
    answer.try(:content)
  end

  def valid_to_delete?
    !self.exams.any?
  end

  def validate_question_type?
    self.single_choice? || self.multiple_choice?
  end

  def validate_answers
    if self.answers.size > 1
      has_answer = self.answers.detect do
        |answer| answer.is_correct? && !answer._destroy
      end
      if has_answer.nil?
        errors[:base] << I18n.t("activerecord.errors.question.select_answer")
      end
    else
      errors[:base] << I18n.t("activerecord.errors.question.add_answer")
    end
  end
end
