class AddStudentNumberToUsers < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :student_number, :string
  	add_column :users, :gender, :integer
  	add_column :users, :picture, :string
  	add_column :users, :school_Grade, :string
  	add_column :users, :degree, :string
  	add_column :users, :father_name, :string
  	add_column :users, :father_email, :string
  	add_column :users, :mother_name, :string
  	add_column :users, :mother_email, :string
  	add_column :users, :Status, :integer
  end
end
