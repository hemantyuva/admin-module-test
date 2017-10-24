class RemovePlaceToExams < ActiveRecord::Migration[5.1]
  def change
  	remove_column :exams,:place,:string
  end
end
