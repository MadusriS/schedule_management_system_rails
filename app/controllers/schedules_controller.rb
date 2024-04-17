class SchedulesController < ApplicationController
    def index
      @schedules = Schedule.all
    end
  
    def new
      @schedule = Schedule.new
    end
    
    def schedule_days(days)
      day_names = { 1 => 'Monday', 2 => 'Tuesday', 4 => 'Wednesday', 8 => 'Thursday', 16 => 'Friday', 32 => 'Saturday', 64 => 'Sunday' }
      selected_days = day_names.select { |key, _value| (days & key) != 0 }.values
      selected_days.join(', ')
    end

  
    def create
      @schedule = Schedule.new(schedule_params)
      @schedule.days = params[:schedule][:days].reject(&:blank?).map(&:to_i).sum if params[:schedule][:days]
      if @schedule.save
        flash[:notice] = 'Schedule created successfully.'
        redirect_to schedules_path
      else
        render :new
      end
    end
  
    def destroy
      @schedule = Schedule.find(params[:id])
      @schedule.destroy
      redirect_to schedules_path, notice: 'Schedule was successfully deleted.'
    end
  
    private

def schedule_params
  params.require(:schedule).permit(:name, :start_time, :end_time)
end
  end
  