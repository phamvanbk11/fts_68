class User < ActiveRecord::Base
  has_many :questions
  has_many :posts
  has_many :comments
  has_many :exams
end
