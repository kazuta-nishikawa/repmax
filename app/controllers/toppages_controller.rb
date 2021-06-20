# frozen_string_literal: true

class ToppagesController < ApplicationController
  def index
    if request.post?
      weight = params[:calc][:weight].to_i
      rep = params[:calc][:rep].to_i
      @repmax = calc_repmax(weight, rep)
    end

    redirect_to user_path(current_user.id) if logged_in?
  end
end
