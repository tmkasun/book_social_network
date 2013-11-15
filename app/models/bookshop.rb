class Bookshop < ActiveRecord::Base
  has_one :credential, as: :login
end
