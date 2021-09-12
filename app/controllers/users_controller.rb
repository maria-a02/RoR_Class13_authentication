class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html {redirect_to root_path}
      else
        render :new
      end
    end
  end

  def show
    @user = User.find(params[:id])
    @stories = Story.where(user_id: @user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
