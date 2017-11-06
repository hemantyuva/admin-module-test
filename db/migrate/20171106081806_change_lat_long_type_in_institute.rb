class ChangeLatLongTypeInInstitute < ActiveRecord::Migration[5.1]
  def up
    remove_column :institutions, :latitude
    add_column :institutions, :latitude, :jsonb
    remove_column :institutions, :longitude
    add_column :institutions, :longitude, :jsonb
  end

  def down
  	remove_column :institutions, :latitude
    remove_column :institutions, :longitude
  end  	
end


