class Schedule < ApplicationRecord
  validates :name, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  validate :no_time_overlaps

  private

  def no_time_overlaps
    if overlapping_schedules.exists?
      errors.add(:base, 'Schedule time overlaps with another schedule')
    end
  end

  def overlapping_schedules
    Schedule.where.not(id: id)
            .where('days & ? != 0', days)
            .where('((start_time <= ? AND end_time > ?) OR 
                     (start_time < ? AND end_time >= ?) OR 
                     (start_time >= ? AND end_time <= ?))',
                   end_time, start_time,
                   end_time, start_time,
                   start_time, end_time)
  end
end

  
   
  
