class AddAdminIdToHomeWorks < ActiveRecord::Migration[5.1]
  def change
    add_column :home_works, :admin_id, :integer
    add_column :home_works, :added_by, :integer
  end
end
