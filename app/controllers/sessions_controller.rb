# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = 'ログインに成功しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end

  private

  def login(email, password)
    # 入力フォームの email と同じメールアドレスを持つユーザを検索し @user へ代入
    @user = User.find_by(email: email)
    # @user が存在するかを確認,@user のパスワードが合っているか、@user.authenticate(password) で確認
    if @user&.authenticate(password)
      # ログイン成功
      session[:user_id] = @user.id
      true
    else
      # ログイン失敗
      false
    end
  end
end
