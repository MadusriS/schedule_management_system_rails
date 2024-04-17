module SchedulesHelper
    def schedule_days(days)
      day_names = { 1 => 'Sunday', 2 => 'Monday', 4 => 'Tuesday', 8 => 'Wednesday', 16 => 'Thursday', 32 => 'Friday', 64 => 'Saturday' }
      selected_days = day_names.select { |key, _value| (days & key) != 0 }.values
      selected_days.join(', ')
    end
  end
  
