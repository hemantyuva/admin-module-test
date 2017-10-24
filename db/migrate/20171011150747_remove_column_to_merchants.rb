class RemoveColumnToMerchants < ActiveRecord::Migration[5.1]
  def change
   
    remove_reference :merchants, :school, index: true, foreign_key: true
    remove_column :events, :group_id, :integer

  end
end
