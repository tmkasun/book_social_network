class CreateCredentials < ActiveRecord::Migration
  def change
    create_table :credentials do |t|
      t.string :username
      t.text :password
      t.references :login, polymorphic: true
      t.timestamps
    end
  end
end
