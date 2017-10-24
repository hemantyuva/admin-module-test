class AddNotesToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :notes, :text
    add_column :events, :group_id, :integer
  end
end
