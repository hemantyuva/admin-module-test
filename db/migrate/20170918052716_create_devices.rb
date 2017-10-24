class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.string :devise_type
      t.string :token
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
