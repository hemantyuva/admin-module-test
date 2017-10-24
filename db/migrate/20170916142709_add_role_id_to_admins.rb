class AddRoleIdToAdmins < ActiveRecord::Migration[5.1]
  def change
    add_column :admins, :role_id, :integer
  end
end
