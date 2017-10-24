class CreateServices < ActiveRecord::Migration[5.1]
  def change
    create_table :services do |t|
      t.string :title
      t.string :photo
      t.text :description
      t.string :email
      t.string :phone_number
      t.references :school, foreign_key: true

      t.timestamps
    end
  end
end
