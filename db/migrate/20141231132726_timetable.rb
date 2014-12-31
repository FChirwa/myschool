class Timetable < ActiveRecord::Migration
  def self.up
 		create_table :timetable, :primary_key => :timetable_id do |t|
			t.t_row :integer
			t.t_column :integer
			t.class_room :integer
      t.integer :voided
      t.timestamps
		end
  end

  def self.down
		drop_table :timetable
  end
end
