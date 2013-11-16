class Book < ActiveRecord::Base
  has_many :interests
  has_many :users, through: :interests

  #This is a comment: The below relationship has some conflicting conditions 
  has_many :users
  has_many :categories , through: :users

  has_many :book_lists
  has_many :grades, through: :book_lists
end
