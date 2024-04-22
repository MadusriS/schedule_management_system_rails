class SchedulesController < ApplicationController
    def index
      @schedules = Schedule.all
    end
  
    def new
      @schedule = Schedule.new
    end
    
    def schedule_days(days)
      day_names = { 1 => 'Sunday', 2 => 'Monday', 4 => 'Tuesday', 8 => 'Wednesday', 16 => 'Thursday', 32 => 'Friday', 64 => 'Saturday' }
      selected_days = day_names.select { |key, _value| (days & key) != 0 }.values
      selected_days.join(', ')
    end
    def schedule_params
      params.require(:schedule).permit(:name, :start_time_hour, :start_time_minute, :start_time_ampm, :end_time_hour, :end_time_minute, :end_time_ampm, days: [])
    end
    
    def create
      @schedule = Schedule.new(schedule_params.except(:days, :start_time_hour, :start_time_minute, :start_time_ampm, :end_time_hour, :end_time_minute, :end_time_ampm))
      
      @schedule.days = params[:schedule][:days].reject(&:blank?).map(&:to_i).sum
      
      @schedule.start_time = convert_to_24_hour(params[:schedule][:start_time_hour], params[:schedule][:start_time_minute], params[:schedule][:start_time_ampm])
      @schedule.end_time = convert_to_24_hour(params[:schedule][:end_time_hour], params[:schedule][:end_time_minute], params[:schedule][:end_time_ampm])
      
      respond_to do |format|
        if @schedule.save
          format.html { redirect_to schedules_path, notice: 'Schedule was successfully created.' }
          format.js   # Render create.js.erb for AJAX response
        else
          format.html { redirect_to new_schedule_url, notice: 'Schedule overlaps.' }
          format.js 
          #format.json { render json: @schedule.errors, status: :unprocessable_entity }
          #format.js { render :new }  # Render new.js.erb with errors for AJAX response
        end
      end
    end
    
    
    
 
  
    def delete_by_criteria
      start_time = params[:start_time]
      task_name = params[:task_name]
      day_name = params[:day_name]
    
      # Find the schedules based on start time, task name, and day
      schedules = Schedule.where(start_time: start_time, name: task_name)
                          .where("days & ? > 0", 2 ** Date.parse(day_name).wday)
    
      if schedules.any?
        # Update and delete each matching schedule
        schedules.each do |schedule|
          # Update the days bitmask by clearing the bit corresponding to the day of the week
          schedule.update(days: schedule.days & ~(2 ** Date.parse(day_name).wday))
           #schedule.destroy
        end
        redirect_to schedules_path, notice: 'Schedules deleted successfully.'
      else
        redirect_to schedules_path, alert: 'No schedules found for the specified criteria.'
      end
    end
    
    
    
    
  
    def destroy
      @schedule = Schedule.find(params[:id])
      @schedule.destroy
      redirect_to schedules_path, notice: 'Schedule was successfully deleted.'
    end
  
    private

  def schedule_params
    params.require(:schedule).permit(:name, :start_time, :end_time, days: [])
  end

  def convert_to_24_hour(hour, minute, ampm)
    # Convert hour and minute to integers
    hour = hour.to_i
    minute = minute.to_i

    # Convert AM/PM to 24-hour format
    if ampm == 'PM' && hour != 12
      hour += 12
    elsif ampm == 'AM' && hour == 12
      hour = 0
    end

    # Format hour and minute with leading zeros
    hour = hour.to_s.rjust(2, '0')
    minute = minute.to_s.rjust(2, '0')

    "#{hour}:#{minute}"
  end
end