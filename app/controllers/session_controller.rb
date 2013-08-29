class SessionController < ApplicationController
	layout "application"
	def new

	end 

	def create 
		user = User.authenticate(params[:username].downcase, params[:password])
		if user 
			session[:user_id] = user.id
			redirect_to root_path
			flash[:notice] = "Sign in successful"
		else
			redirect_to root_path
			flash[:notice] = "Username or Password incorrect"
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path
		flash[:notice] = "Sign Out successful"
	end 

end 
