# frozen_string_literal: true

class RecordsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: %i[destroy edit update]

  def new
    @record = Record.new
  end

  def create
    @record = current_user.records.build(record_params)

    if @record.save
      flash[:success] = '記録しました。'
      redirect_to user_path(current_user.id)
    else
      flash.now[:danger] = '記録に失敗しました。'
      render :new
    end
  end

  def edit
    @record = Record.find(params[:id])
  end

  def update
    @record = current_user.records.find(params[:id])

    if @record.update(record_params)
      flash[:success] = '記録を編集しました。'
      redirect_to user_path(current_user.id)
    else
      @records = current_user.records.order(id: :desc).page(params[:page])
      flash.now[:danger] = '記録の編集に失敗しました。'
      render user_path(current_user.id)
    end
  end

  def destroy
    @record.destroy
    flash[:success] = '削除しました。'
    redirect_back(fallback_location: user_path(current_user.id))
  end

  private

  def record_params
    params.require(:record).permit(:date, :workout, :rep, :weight)
  end

  def correct_user
    @record = current_user.records.find_by(id: params[:id])
    redirect_to user_path(current_user.id) unless @record
  end
end
