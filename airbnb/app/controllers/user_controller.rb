class UserController < ApplicationController

	def add_user
		response = Hash.new
		salt_value, password_diggest = UserService.instance().get_password_digest(params[:password])
		@user = User.new email: params[:email], firstname: params[:firstname], lastname: params[:lastname], password_diggest: password_diggest, salt: salt_value
		response = Hash.new

		if @user.valid? && @user.save
			session[:user_id] = User.find_by_email(params[:email]).id
			session[:user_firstname] = params[:firstname]
			response[:status] = "success"
		else
			response = @user.errors
		end
		render json: response
	end
	
end
