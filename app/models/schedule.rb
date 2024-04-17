class Schedule < ApplicationRecord
    validates :name, presence: true
    validates :start_time, presence: true
    validates :end_time, presence: true
  
    validate :no_time_overlaps
  
    private

  def no_time_overlaps
    overlapping = Schedule.where.not(id: id).where(days: days)
                          .where('start_time < ? AND end_time > ?', end_time, start_time)
    errors.add(:base, 'Schedule time overlaps with another schedule') if overlapping.exists?
  end
end
  
   
  
