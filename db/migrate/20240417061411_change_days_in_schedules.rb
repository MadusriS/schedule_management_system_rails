class ChangeDaysInSchedules < ActiveRecord::Migration[7.0]
  def up
    # Set a default value for existing records
    Schedule.where(days: nil).update_all(days: 0)

    # Change the column to not allow null and set a default value
    change_column :schedules, :days, :integer, default: 0, null: false
  end

  def down
    # Revert the column to allow null, remove default (if necessary)
    change_column :schedules, :days, :integer, null: true, default: nil
  end
end

