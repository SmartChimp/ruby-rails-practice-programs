class ReservationController < ApplicationController


	def initialize
		@reserve_service = ReservationService.instance()
	end

	def user_bookings
		if (session[:user_id] != nil) 
			reservations = @reserve_service.get_reserved_spaces_by_user(session[:user_id])
			render :partial => "your_bookings", :layout => false, :collection => reservations, :as => :reservation
		else
			render "welcome/home"
		end
	end
end
