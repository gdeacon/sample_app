class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, 	 only: [:edit, :update]
  before_action : admin_user,	 only: :destroy
  
  
  def new
	@user = User.new
  end
  
  def index
	@title = "All users"
	#paginate users
	@users = User.paginate(page: params[:page])
  end
  
  
  def show
	@user = User.find(params[:id])
	@title = @user.name
  end
  
  def create
	@user = User.new(user_params) #not final implementaton
	if @user.save
		log_in @user
		flash[:success] = "Welcome to the Sample App!"
		redirect_to @user
	else
		@title = "Sign up"
		render 'new'
	end
  end
  
  def edit
	@title = "Edit user"
  end
  
  def update
	if @user.update_attributes(user_params)
		flash[:success] = "Profile updated"
		redirect_to @user
	else
		render 'edit'
	end
  end
  
  def destroy
	User.find(params[:id]).destroy
	flash[:success] = "User deleted"
	redirect_to users_url
  end
  
  
  private
	  def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	  end
	  
	  #Confirms a logged-in user
	  def logged_in_user
		unless logged_in?
			#hold on to the location the user was attempting for later redirection
			store_location
			flash[:danger] = "Please log in."
			redirect_to login_url
		end
	  end
		
	  #confirm the correct user
	  def correct_user
		@user = User.find(params[:id])
		redirect_to(root_url) unless current_user?(@user)
	  end
  
	  #Confirm an admin user
	  def admin_user
		redirect_to(root_url) unless correct_user.admin?
	  end
	  
  
end
