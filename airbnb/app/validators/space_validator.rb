class SpaceValidator < ActiveModel::Validator

	def validate(space)
		if Airbnb::ROOM_TYPES[space.room_type] == nil
			space.errors[:base] << ResponseUtils.INVALID_ROOM_TYPE
		elsif Airbnb::HOME_TYPES[space.home_type] == nil
			space.errors[:base] << ResponseUtils.INVALID_HOME_TYPE
		end
	end
end