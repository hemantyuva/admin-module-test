class CreateHomeWorks < ActiveRecord::Migration[5.1]
  def change
    create_table :home_works do |t|
      t.date :deadline_date
      t.string :deadline_time
      t.text :description
      t.string :reminder
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
