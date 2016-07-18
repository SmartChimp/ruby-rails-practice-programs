class UserController < ApplicationController

	def add
		user_request = AddUser.new params[:user]
		response = Hash.new

		if UserService.instance().add_user(user_request) 
			@user = User.find_by_email(user_request.email)
			session[:user_id] = @user.id
			session[:user_firstname] = user_request.firstname
			response[:status] = "success"
		else
			response[:status] = "error"
		end
		render json: response
	end
	
end
