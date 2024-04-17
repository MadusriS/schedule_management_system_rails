module SchedulesHelper
    def schedule_days(days)
      day_names = { 1 => 'Monday', 2 => 'Tuesday', 4 => 'Wednesday', 8 => 'Thursday', 16 => 'Friday', 32 => 'Saturday', 64 => 'Sunday' }
      selected_days = day_names.select { |key, _value| (days & key) != 0 }.values
      selected_days.join(', ')
    end
  end
  
