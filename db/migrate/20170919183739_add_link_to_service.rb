class AddLinkToService < ActiveRecord::Migration[5.1]
  def change
    add_column :services, :link, :string
    add_column :services, :Document_Link, :string
    add_column :services, :Notes, :text
  end
end
