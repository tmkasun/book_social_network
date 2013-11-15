class Category < ActiveRecord::Base
  has_many :users
  has_many :books, through: :users
end
