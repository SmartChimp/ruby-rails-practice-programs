class AuthenticationController < ApplicationController
	
	def signup
		render :layout => false
	end

	def login
		render :layout => false
	end

	def logout
		session[:user_id] = nil
		render nothing: true
	end

	def authenticate
		@user = User.find_by_email params[:email]
		response = Hash.new
		
		if @user
			if UserService.instance().valid_user? @user, params[:password]
				session[:user_id] = @user.id
				session[:user_firstname] = @user.firstname 
				response[:status] = "success"
			else
				response[:status] = "failure"
				response[:error_message] = "Invalid password."
			end
		else
			response[:status] = "failure"
			response[:error_message] = "Invalid email."
		end
		render json: response
	end

end
