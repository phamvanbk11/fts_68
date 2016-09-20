class Subject < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  has_many :exams
  has_many :posts
  scope :updated_desc, -> {order updated_at: :desc}
  validates :name, presence: true, length: {maximum: 50}
  validates :number_of_questions, presence: true,
    numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 200}
  validates :duration, presence: true,
    numericality: {greater_than_or_equal_to: 1}
end
