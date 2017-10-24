class CreateExams < ActiveRecord::Migration[5.1]
  def change
    create_table :exams do |t|
      t.string :exam_name
      t.date :exam_date
      t.time :start_time
      t.time :end_time
      t.string :place
      t.string :reminder
      t.string :notes
      t.references :school, foreign_key: true
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
