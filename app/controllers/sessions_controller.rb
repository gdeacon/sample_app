class SessionsController < ApplicationController
  def new
	@title = "Log in"
  end
  
  def create
	user = User.find_by(email: params[:session][:email].downcase)
	if user && user.authenticate(params[:session][:password])
		#log in the user and redirect to the user's home page
		#log_in will store the user to the session
		log_in user
		#interogate the rmember_me params
		params[:session][:remember_me] == '1' ? remember(user) : forget(user)
		#redirect_to user
		redirect_back_or user
	else
		#create an error message
		@title = "Log in"
		flash.now[:error] = 'Invalid email/password combination' # Not quite right!
		render 'new'
	end
  end
  
  def destroy
	log_out if logged_in?
	redirect_to root_url
  end
end
