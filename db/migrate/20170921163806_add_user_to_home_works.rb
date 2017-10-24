class AddUserToHomeWorks < ActiveRecord::Migration[5.1]
  def change
    add_column :home_works, :user_id, :integer
  end
end
