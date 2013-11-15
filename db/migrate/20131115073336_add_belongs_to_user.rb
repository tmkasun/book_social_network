class AddBelongsToUser < ActiveRecord::Migration
  def change
    add_belongs_to :users, :categories
    add_belongs_to :users, :books
  end
end
