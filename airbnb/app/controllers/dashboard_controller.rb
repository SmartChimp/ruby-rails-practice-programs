class DashboardController < ApplicationController

	def dashboard
		if !(session[:user_id] != nil)
			render "/welcome/home"
		end
	end
	
end