class AddUser
	attr_accessor :firstname, :lastname, :email, :password

	def initialize(args)
		@firstname = args["firstname"]
		@lastname = args["lastname"]
		@password = args["password"]
		@email = args["email"]
	end

end