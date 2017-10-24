class CreateInstitutions < ActiveRecord::Migration[5.1]
  def change
    create_table :institutions do |t|
      t.string :name
      t.string :location
      t.string :description
      t.string :contact_personal
      t.string :contact_number
      t.string :email
      t.timestamps
    end
  end
end
