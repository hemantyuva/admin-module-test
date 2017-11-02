class CreateSchoolServices < ActiveRecord::Migration[5.1]
  def change
    create_table :school_services do |t|
      t.integer :school_id
      t.integer :service_id

      t.timestamps
    end
  end
end
