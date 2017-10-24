class CreateMerchants < ActiveRecord::Migration[5.1]
  def change
    create_table :merchants do |t|
      t.string :name
      t.string :title
      t.text :description
      t.string :picture
      t.references :school, foreign_key: true

      t.timestamps
    end
  end
end
