class DashboardsController < ApplicationController

	def show
		return render "/welcome/home" if !is_user_session_exists?
	end
	
end