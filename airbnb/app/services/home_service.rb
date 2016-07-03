class HomeService
	include Singleton

	public

	def get_all_home_types
		(@home_types == nil) ? @home_types = Home.all( :select => "id, home_type") : @home_types;
	end

end