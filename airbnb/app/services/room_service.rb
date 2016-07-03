class RoomService

	include Singleton

	public

	def get_all_room_types
		(@room_types == nil) ? @room_types = Room.all( :select => "id, room_type") : @room_types;
	end
end