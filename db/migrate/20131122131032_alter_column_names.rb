class AlterColumnNames < ActiveRecord::Migration
  def change

    rename_column :users ,:first_name, :firstname
    rename_column :users ,:last_name , :secondname
    rename_column :users ,:date_of_birth ,:dob
  end
end
