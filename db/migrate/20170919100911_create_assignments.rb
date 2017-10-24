class CreateAssignments < ActiveRecord::Migration[5.1]
  def change
    create_table :assignments do |t|
      t.references :user, foreign_key: true
      t.references :school, foreign_key: true
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
