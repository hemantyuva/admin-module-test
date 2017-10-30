class CreateAdminInstitutions < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_institutions do |t|
      t.integer :admin_id 
      t.integer :institution_id 
      t.timestamps
    end
  end
end
