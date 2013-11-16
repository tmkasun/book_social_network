class Bookshop < ActiveRecord::Base
  has_one :credential, as: :login

  has_many :inventories
  has_many :books, through: :inventories
end
