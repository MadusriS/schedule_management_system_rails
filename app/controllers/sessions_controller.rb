class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page
      session[:user_id] = user.id
      respond_to do |format|
        format.html { redirect_to schedules_path, notice: 'Logged in successfully.' }
        format.js
      end
    else
      # Create an error message
      respond_to do |format|
        format.html { redirect_to new_session_path, alert: 'Invalid email/password combination.' }
        format.js
      end
    end
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_url, notice: 'Logged out successfully.'
  end
end





