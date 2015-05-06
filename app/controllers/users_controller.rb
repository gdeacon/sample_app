class UsersController < ApplicationController
  def new
	@user = User.new
  end
  
  def show
	@user = User.find(params[:id])
	@title = @user.name
  end
  
  def create
	@user = User.new(user_params) #not final implementaton
	if @user.save
		login_in @user
		flash[:success] = "Welcome to the Sample App!"
		redirect_to @user
	else
		@title = "Sign up"
		render 'new'
	end
  end
  
  private
	  def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	  end
  
end
