class AuthenticationController < ApplicationController
	
	def initialize
		@response_helper = ResponseUtils.instance()
	end

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
		
		if @user
			if UserService.instance().valid_user? @user, params[:password]
				session[:user_id] = @user.id
				session[:user_firstname] = @user.firstname 
				render json: @response_helper.get_response_object(ResponseUtils.SUCCESS)
			else
				render json: @response_helper.get_response_object(ResponseUtils.ERROR, ResponseUtils.PASS_ERR)
			end
		else
			render json: @response_helper.get_response_object(ResponseUtils.ERROR, ResponseUtils.EMAIL_ERR)
		end
	end

end
