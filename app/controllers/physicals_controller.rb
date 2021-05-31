class PhysicalsController < ApplicationController
  
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def show
    @user = User.find(params[:id])
    @physical_data = @user.physicals.order(date: :desc).page(params[:page])
  end

  def new
    @physical_data = current_user.physicals.build
  end

  def create
    @physical_data = current_user.physicals.build(physical_params)
    if @physical_data.save
      flash[:success] = '記録しました。'
      redirect_to physical_path(current_user.id)
    else
      @physical_data = current_user.physicals.build
      flash.now[:danger] = '記録に失敗しました。身体データは1日につき１つです。変更する場合は編集してください。'
      render :new
    end
    
  end

  def edit
    @physical_data = Physical.find(params[:id])
  end

  def update
    @physical_data = current_user.physicals.find(params[:id])
    
      if @physical_data.update(physical_params)
        flash[:success] = '記録を編集しました。'
        redirect_to physical_path(current_user.id)
      else
        @physical_data = current_user.physicals.order(id: :desc).page(params[:page])
        flash.now[:danger] = '記録の編集に失敗しました。'
        render physical_path(current_user.id)
      end
  end

  def destroy
    @physical_data.destroy
    flash[:success] = '削除しました。'
    redirect_back(fallback_location: physical_path(current_user.id))
  end
end

private

  def physical_params
    params.require(:physical).permit(:body_weight, :body_fat_ratio, :date)
  end
  
  def correct_user
      @physical_data = current_user.physicals.find_by(id: params[:id])
      unless @physical_data
        redirect_to physical_path(current_user) 
      end
  end