class ApplicationController < ActionController::Base
  
include SessionsHelper
include RecordsHelper



  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def correct_user
    @record = current_user.records.find_by(id: params[:id])
    unless @record
      redirect_to  user_path(current_user.id)
    end
  end
  
end