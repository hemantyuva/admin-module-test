class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title
      t.date :start_date
      t.date :end_date
      t.time :start_time
      t.time :end_time
      t.string :location
      t.string :event_type
      t.string :reminder
      t.text :description
      t.references :school, foreign_key: true

      t.timestamps
    end
  end
end
