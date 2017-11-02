class CreateAdminSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_subjects do |t|
      t.integer :subject_id
      t.integer :admin_id

      t.timestamps
    end
  end
end
