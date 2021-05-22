class UsersController < ApplicationController
  # ログインしなければ実行されずにログイン画面に遷移する処理
   before_action :require_user_logged_in, only: [:index, :show, :edit, :update]
   
  def index
     @users = User.order(id: :desc).page(params[:page]).per(25)
  end
  
  def show
    @user = User.find(params[:id])
    @records = current_user.records.order(id: :desc).page(params[:page])
    
    if @user.birthday
      @age = (Date.today.strftime("%Y%m%d").to_i - @user.birthday.strftime("%Y%m%d").to_i) / 10000
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
    params.require(:user).permit(:name, :email, :password, :password_confirmation,:birthday, :description,:height)
  end
  
end
