class CreateBookshops < ActiveRecord::Migration
  def change
    create_table :bookshops do |t|
      t.string :name
      t.string :location
      t.timestamps
    end
  end
end
