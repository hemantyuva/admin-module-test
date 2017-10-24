class CreateAdminSchools < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_schools do |t|
    	t.integer :admin_id
        t.integer :school_id
      	t.timestamps
    end
  end
end
