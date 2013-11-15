class Credential < ActiveRecord::Base
  validates :username, uniqueness: true
  belongs_to :login, polymorphic: true

end
