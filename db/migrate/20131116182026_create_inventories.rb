class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.belongs_to :bookshop
      t.belongs_to :book
      t.integer :quantity
      t.timestamps
    end
  end
end
