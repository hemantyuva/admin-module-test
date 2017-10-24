class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.string :title
      t.text :description
      t.string :image
      t.string :coupon_code
      t.date :begin_date
      t.date :expire_date
      t.integer :total_coupon
      t.string :status
      t.references :merchant, foreign_key: true

      t.timestamps
    end
  end
end
