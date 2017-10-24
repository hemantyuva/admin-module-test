class AddLatitudeToSchools < ActiveRecord::Migration[5.1]
  def change

		add_column :schools, :logo, :string
		add_column :schools, :country, :string
		add_column :schools, :state, :string
		add_column :schools, :status, :string
		add_column :schools , :contact_id, :integer
  end
end
