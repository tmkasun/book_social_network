class User < ActiveRecord::Base
  has_many :interests
  has_many :books , through: :interests

  has_one :credential, as: :login

  #FIXME this
  belongs_to :category
  belongs_to :book
end
