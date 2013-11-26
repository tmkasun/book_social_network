class School < ActiveRecord::Base
  has_many :grades
  has_one :credential, as: :login
  
  has_many :books
end
