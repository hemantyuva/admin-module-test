class CreateMerchantSchools < ActiveRecord::Migration[5.1]
  def change
    create_table :merchant_schools do |t|
      t.integer :merchant_id
      t.integer :school_id

      t.timestamps
    end
  end
end
