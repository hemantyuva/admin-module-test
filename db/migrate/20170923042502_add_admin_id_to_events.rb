class AddAdminIdToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :admin_id, :integer
    add_column :events, :added_by, :integer
    add_column :events, :user_id, :integer
  end
end
