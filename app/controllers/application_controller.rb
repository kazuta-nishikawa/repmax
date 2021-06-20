# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper
  include RecordsHelper

  private

  def require_user_logged_in
    redirect_to login_url unless logged_in?
  end
end
