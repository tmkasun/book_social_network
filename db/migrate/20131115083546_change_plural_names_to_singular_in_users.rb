class ChangePluralNamesToSingularInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :books_id, :book_id
    rename_column :users, :categories_id, :category_id
  end
end
