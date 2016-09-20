class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :results
  validates :content, presence: true, length: {maximum: 255}
end
