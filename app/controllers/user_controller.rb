class UserController < ApplicationController

	def new 

	end 

	def create 
		@user = User.create(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to root_path
			flash[:notice] = "Your account was successfully created and you are now signed in"
		else 
			redirect_to new_user_path
			flash[:notice] = "There was a problem creating your account"
		end 
	end 

	def edit

	end 

	def update 

	end 

	def show 
		@user = User.find(params[:id])
	end 

	def index 
		@users = User.all
	end 

	def follow 
		@user = current_user
		@user.follow!(params[:query])
		redirect_to root_path
	end

	private 

	def user_params 
		params.require(:user).permit :fname, :lname, :email, :username, :password
	end 

end 