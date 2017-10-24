class CreateSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :schedules do |t|
		t.string :ClassRoom
		t.string :Monday
		t.string :Tuesday
		t.string :Wednesday
		t.string :Thursday
		t.string :Friday
		t.string :Saturday
		t.references :subject, foreign_key: true
		t.references :group, foreign_key: true
		t.references :admin, foreign_key: true

      t.timestamps
    end
  end
end
