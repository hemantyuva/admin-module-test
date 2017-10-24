class CreateGeneralConfigurations < ActiveRecord::Migration[5.1]
  def change
    create_table :general_configurations do |t|
      t.string :key_name
      t.string :value

      t.timestamps
    end
  end
end
