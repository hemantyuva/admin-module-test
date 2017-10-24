class CreateSchools < ActiveRecord::Migration[5.1]
  def change
    create_table :schools do |t|
      t.string :name
      t.string :location
      t.string :description
      t.string :contact_personal
      t.string :contact_number
      t.string :email
      t.decimal :latitude
      t.decimal :longitude
      t.references :institution, foreign_key: true

      t.timestamps
    end
  end
end
