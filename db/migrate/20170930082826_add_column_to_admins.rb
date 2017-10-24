class AddColumnToAdmins < ActiveRecord::Migration[5.1]
  def change
    add_column :admins, :institution_id, :integer
  end
end
