# frozen_string_literal: true

class UsersController < ApplicationController
  require 'csv'

  # ログインしなければ実行されずにログイン画面に遷移する処理
  before_action :require_user_logged_in, only: %i[show edit update]
  before_action :correct_user, only: %i[edit update]

  def show
    @user = User.find(params[:id])
    @physical_data = @user.physicals.order(date: :desc).page(params[:page])
    @records = @user.records.order(date: :desc).page(params[:page])

    @age = (Date.today.strftime('%Y%m%d').to_i - @user.birthday.strftime('%Y%m%d').to_i) / 10_000 if @user.birthday

    # csv用コード
    # respond_to はリクエストに応じた処理を行うメソッドです。
    # 通常時はhtmlをリクエストしているので、処理は記述していません。
    # viewのlink_toでformatをcsvとして指定しているので、
    # リンクを押すとsend_records_csv(@records)の処理を行います。
    respond_to do |format|
      format.html
      format.csv do |_csv|
        send_records_csv(@records, @physical_data)
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = 'ユーザー情報は正常に更新されました'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザー情報は更新されませんでした。'
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :birthday, :description, :height)
  end

  def send_records_csv(records, physical_data)
    csv_data = CSV.generate do |csv|
      column_names = %w[date Workout weight rep repmax ratio body_weight body_fat_ratio]
      csv << column_names
      records.each do |record|
        @date = record.date
        column_values = [
          record.date,
          record.workout,
          record.weight,
          record.rep,
          calc_repmax(record.weight, record.rep)
        ]
        physical_data.group_by(&:date).each do |date, data|
          next unless @date == date

          data.each do |datum|
            column_values << calc_ratio(datum.body_weight)
            column_values << datum.body_weight
            column_values << datum.body_fat_ratio
          end
        end

        csv << column_values
      end
    end
    send_data(csv_data, filename: 'repmax.csv')
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user) unless current_user == @user
  end
end
