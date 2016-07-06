class ResponseUtils

	@@EMAIL_ERR = "EMAIL_ERR"
	@@PASS_ERR = "PASS_ERR"
	@@SUCCESS = "SUCCESS"
	@@ERROR = "ERROR"
	@@SPACE_NOT_AVAILABLE = "SPACE_NOT_AVAILABLE"

	include Singleton

	def initialize
		@RESPONSE_MESSAGE_MAP = Hash.new
		@RESPONSE_MESSAGE_MAP[@@EMAIL_ERR] = "Invalid email."
		@RESPONSE_MESSAGE_MAP[@@PASS_ERR] = "Invalid password."
		@RESPONSE_MESSAGE_MAP[@@SUCCESS] = "success"
		@RESPONSE_MESSAGE_MAP[@@ERROR] = "error"
		@RESPONSE_MESSAGE_MAP[@@SPACE_NOT_AVAILABLE] = "Requested space is not available now."
	end

	public 

	def get_response_object(status, *arg)
		response = Hash.new
		response[:status] = @RESPONSE_MESSAGE_MAP[status]
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

end