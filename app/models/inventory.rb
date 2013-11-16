class Inventory < ActiveRecord::Base
  belongs_to :bookshop
  belongs_to :book
end
