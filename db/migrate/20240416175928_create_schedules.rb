class CreateSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :schedules do |t|
      t.string :name
      t.integer :days
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
