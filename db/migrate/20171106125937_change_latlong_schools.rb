class ChangeLatlongSchools < ActiveRecord::Migration[5.1]
  def up
    remove_column :schools, :latitude
    add_column :schools, :latitude, :jsonb
    remove_column :schools, :longitude
    add_column :schools, :longitude, :jsonb
  end

  def down
  	remove_column :schools, :latitude
    remove_column :schools, :longitude
  end  	
end
