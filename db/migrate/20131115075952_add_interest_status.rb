class AddInterestStatus < ActiveRecord::Migration
  def change
    add_column :interests , :read, :boolean , default: false
  end
end
