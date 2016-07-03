class SpaceController < ApplicationController
	include SpaceHelper

	def initialize
		@space_service = SpaceService.instance()
		@home_service = HomeService.instance()
		@room_service = RoomService.instance()
		@city_service = CityService.instance()
		@reserve_service = ReservationService.instance()
	end

	def list_user_space
		if (session[:user_id] != nil) 
			@spaces = @space_service.get_all_spaces_for_user session[:user_id]
			@home_types = @home_service.get_all_home_types
			@room_types = @room_service.get_all_room_types
			render :layout => false
		else
			render "welcome/home"
		end
	end

	def add_space
		space = Space.new params[:space]
		space.user_id = session[:user_id]
		space.save ? render(nothing: true) : render(nothing: false)
	end

	def get_cities
		render json: ConstructJSONResponse::for_cities_like(@city_service.get_cities_like params[:q])
	end

	def search
		@spaces = @space_service.search_for_spaces(Search.new params[:search])
	end

	def reserve
		reserve_space = ReserveSpace.new params[:reserve]
		reserve_space.user_id = session[:user_id]
		@reserve_service.reserve(reserve_space)? render(nothing: true) : render(nothing: false)
	end

	def new_booking
	end
end
