class ReservationsController < ApplicationController

	def initialize
		@response_helper = ResponseUtils.instance()
		@reservation_service = ReservationService.instance()
	end

	def index
		return render "welcome/home" if !is_user_session_exists?
		reservations = Reservation.get_reserved_spaces_by_user(session[:user_id])
		render :partial => "reservations", :layout => false, :collection => reservations, :as => :reservation
	end

	def create
		reserve_space = ReserveSpace.new params[:reserve]
		reserve_space.user_id = session[:user_id]
		if @reservation_service.reserve(reserve_space)
			render json: @response_helper.get_response_object(ResponseUtils.SUCCESS) 
		else 
			render json: @response_helper.get_response_object(ResponseUtils.ERROR, ResponseUtils.SPACE_NOT_AVAILABLE)
		end
	rescue Exception => e
		puts "Exception : #{e}"
		render json: @response_helper.get_response_object(ResponseUtils.ERROR, ResponseUtils.SPACE_NOT_AVAILABLE)
	end

	def new
	end
	
end
