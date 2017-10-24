class AddAdminIdToExams < ActiveRecord::Migration[5.1]
  def change
    add_column :exams, :admin_id, :integer
    add_column :exams, :added_by, :integer
     add_column :exams, :user_id, :integer
  end
end
