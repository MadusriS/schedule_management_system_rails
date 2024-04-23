class Schedule < ApplicationRecord
  validates :name, presence: { message: "can't be blank" }
  validates :start_time, presence: { message: "can't be blank" }
  validates :end_time, presence: { message: "can't be blank" }
  validates :days, presence: { message: "can't be blank" }

  validate :no_time_overlaps

  private

  def no_time_overlaps
    if overlapping_schedules.exists?
      #flash.now[:alert] = 'Schedule overlaps.'
      errors.add(:base, 'Schedule time overlaps with another schedule')
      
    end
  end

  def overlapping_schedules
    Schedule.where.not(id: id)
            .where('days & ? != 0', days)
            .where('((start_time <= ? AND end_time > ?) OR 
                     (start_time < ? AND end_time >= ?) OR 
                     (start_time >= ? AND end_time <=?))',
                   end_time, start_time,
                   end_time, start_time,
                   start_time, end_time)
  end
  attr_accessor :start_time_hour, :start_time_minute, :start_time_meridian
  attr_accessor :end_time_hour, :end_time_minute, :end_time_meridian

  # Define a custom setter method to combine start_time components into start_time attribute
  def start_time_hour=(hour)
    @start_time_hour = hour
    self.start_time = combine_time_components(hour, start_time_minute, start_time_meridian)
  end

  def start_time_minute=(minute)
    @start_time_minute = minute
    self.start_time = combine_time_components(start_time_hour, minute, start_time_meridian)
  end

  def start_time_meridian=(meridian)
    @start_time_meridian = meridian
    self.start_time = combine_time_components(start_time_hour, start_time_minute, meridian)
  end

  # Define a custom setter method to combine end_time components into end_time attribute
  def end_time_hour=(hour)
    @end_time_hour = hour
    self.end_time = combine_time_components(hour, end_time_minute, end_time_meridian)
  end

  def end_time_minute=(minute)
    @end_time_minute = minute
    self.end_time = combine_time_components(end_time_hour, minute, end_time_meridian)
  end

  def end_time_meridian=(meridian)
    @end_time_meridian = meridian
    self.end_time = combine_time_components(end_time_hour, end_time_minute, meridian)
  end

  private

  # Combine time components into a DateTime object
  def combine_time_components(hour, minute, meridian)
    # Combine components into a string in HH:MM format
    time_string = "#{hour}:#{minute}"

    # Convert to 24-hour format if meridian is PM
    if meridian == 'PM' && hour != '12'
      time_string = (hour.to_i + 12).to_s + ":#{minute}"
    end

    # Parse the time string into a DateTime object
    DateTime.parse(time_string)
  end
end

  
   
  
