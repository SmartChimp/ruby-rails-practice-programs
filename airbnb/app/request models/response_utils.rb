class ResponseUtils

	@@EMAIL_ERR = "EMAIL_ERR"
	@@PASS_ERR = "PASS_ERR"
	@@SUCCESS = "SUCCESS"
	@@ERROR = "ERROR"
	@@SPACE_NOT_AVAILABLE = "SPACE_NOT_AVAILABLE"
	@@ADD_SPACE_ERR = "ADD_SPACE_ERR"
	@@INVALID_ROOM_TYPE = "INVALID_ROOM_TYPE"
	@@INVALID_HOME_TYPE = "INVALID_HOME_TYPE"

	include Singleton

	def initialize
		@RESPONSE_MESSAGE_MAP = Hash.new
		@RESPONSE_MESSAGE_MAP[@@EMAIL_ERR] = "Invalid email."
		@RESPONSE_MESSAGE_MAP[@@PASS_ERR] = "Invalid password."
		@RESPONSE_MESSAGE_MAP[@@SUCCESS] = "success"
		@RESPONSE_MESSAGE_MAP[@@ERROR] = "error"
		@RESPONSE_MESSAGE_MAP[@@SPACE_NOT_AVAILABLE] = "Requested space is not available now."
		@RESPONSE_MESSAGE_MAP[@@ADD_SPACE_ERR] = "Space could not be added."
		@RESPONSE_MESSAGE_MAP[@@INVALID_ROOM_TYPE] = "Invalid room type."
		@RESPONSE_MESSAGE_MAP[@@INVALID_HOME_TYPE] = "Invalid home type."
	end

	public 

	def get_response_object(status, *arg)
		response = Hash.new
		response[:status] = @RESPONSE_MESSAGE_MAP[status]
		puts "message args : #{arg[0]}"
		response[:error_message] = @RESPONSE_MESSAGE_MAP[arg[0]]
		return response
	end

	def self.EMAIL_ERR
		@@EMAIL_ERR
	end

	def self.ERROR
		@@ERROR
	end

	def self.SUCCESS
		@@SUCCESS
	end

	def self.PASS_ERR
		@@PASS_ERR
	end

	def self.SPACE_NOT_AVAILABLE
		@@SPACE_NOT_AVAILABLE
	end

	def self.set_error_message(response, err_msg)
		response[:error_message] = err_msg
	end

	def self.INVALID_HOME_TYPE
		@@INVALID_HOME_TYPE
	end

	def self.INVALID_ROOM_TYPE
		@@INVALID_ROOM_TYPE
	end
end