class UpdateCredentialsUsername < ActiveRecord::Migration
  def change
    change_column(:credentials , :username, :string, unique: true)
  end
end
