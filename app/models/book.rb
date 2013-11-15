class Book < ActiveRecord::Base
  has_many :interests
  has_many :users, through: :interests

  has_many :users
  has_many :categories , through: :users
end
