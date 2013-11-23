class AddCatagoryToInterest < ActiveRecord::Migration
  def change

    add_column :interests, :category, :string
  end
end
