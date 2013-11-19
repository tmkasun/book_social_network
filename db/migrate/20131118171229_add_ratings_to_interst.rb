class AddRatingsToInterst < ActiveRecord::Migration
  def change
    add_column :interests, :rating, :integer, default: 0
  end
end
