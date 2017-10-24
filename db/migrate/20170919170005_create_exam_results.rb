class CreateExamResults < ActiveRecord::Migration[5.1]
  def change
    create_table :exam_results do |t|
      t.references :exam, foreign_key: true
      t.references :user, foreign_key: true
      t.decimal :score
      t.string :abasent

      t.timestamps
    end
  end
end
