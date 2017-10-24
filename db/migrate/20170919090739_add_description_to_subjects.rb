class AddDescriptionToSubjects < ActiveRecord::Migration[5.1]
  def change
    add_column :subjects, :description, :text
    add_column :subjects, :Subject_ID, :string
    add_column :subjects, :school_id, :integer
  end
end
