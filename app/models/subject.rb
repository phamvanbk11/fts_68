class Subject < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  has_many :exams
  has_many :posts
end
