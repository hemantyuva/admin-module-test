class AddTitleToHomework < ActiveRecord::Migration[5.1]
  def change
    add_column :home_works, :title, :string
    add_column :home_works, :school_id, :integer
    add_column :home_works, :group_id, :integer
    add_column :home_works, :notes, :text
  end
end
