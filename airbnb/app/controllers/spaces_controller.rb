class SpacesController < ApplicationController
	include SpacesHelper

	def initialize
		@response_helper = ResponseUtils.instance()
	end

	def index
		return render "welcome/home" if !is_user_session_exists?
		@spaces = Space.get_all_spaces_for_user session[:user_id]
		render :layout => false
	end

	def create
		return render "welcome/home" if !is_user_session_exists?
    space = Space.new params[:space]
    if !space.valid?
    	return render json: @response_helper.get_response_object(ResponseUtils.ERROR, space.errors[:base][0]) 
  	end
	    
		space.user_id = session[:user_id]
		if space.save
      render json: @response_helper.get_response_object(ResponseUtils.SUCCESS)
    else
      render json: @response_helper.get_response_object(ResponseUtils.ERROR,ResponseUtils.ADD_SPACE_ERR)
    end
	end

	def get_cities
		render json: ConstructJSONResponse::for_cities_like(City.get_cities_like params[:q])
	end

	def search
    search_request = Search.new params[:search]
		@spaces = Space.search_for_spaces(search_request).push(*Space.search_for_shared_room_types(search_request))
	end

  def reservations
    return render "welcome/home" if !is_user_session_exists?
    @reservations = Reservation.get_all_reservations_by_user_space(params[:id], session[:user_id])
  end
end
