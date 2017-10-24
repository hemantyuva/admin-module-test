class AddGroupIdToExams < ActiveRecord::Migration[5.1]
  def change
    add_reference :exams, :group, foreign_key: true
    add_column :exams,:classroom,:string
    add_column :exams,:description,:text
  end
end
