class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.string :name
      t.string :authoriser
      t.belongs_to :school
      t.timestamps
    end
  end
end
