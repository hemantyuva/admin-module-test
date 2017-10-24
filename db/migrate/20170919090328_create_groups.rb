class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.string :Group_ID
      t.string :description
      t.references :school, foreign_key: true

      t.timestamps
    end
  end
end
