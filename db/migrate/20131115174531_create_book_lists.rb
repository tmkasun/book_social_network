class CreateBookLists < ActiveRecord::Migration
  def change
    create_table :book_lists do |t|
      t.belongs_to :book
      t.belongs_to :grade
      t.timestamps
    end
  end
end
