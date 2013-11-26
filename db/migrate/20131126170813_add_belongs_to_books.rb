class AddBelongsToBooks < ActiveRecord::Migration
  def change
    add_belongs_to :books, :school

  end
end
