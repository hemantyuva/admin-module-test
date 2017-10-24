class AddLatitudeToInstitutions < ActiveRecord::Migration[5.1]
  def change
    	add_column :institutions, :latitude, :decimal
		add_column :institutions, :longitude, :decimal
		add_column :institutions, :logo, :string
		add_column :institutions, :country, :string
		add_column :institutions, :state, :string
		add_column :institutions, :status, :string
		add_column :institutions , :contact_id, :integer
  end
end
