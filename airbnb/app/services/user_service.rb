class UserService
	
	include Singleton
	require 'securerandom'

	public

	def get_password_digest(password)
		salt_value = SecureRandom.hex 5
		salted_password = password+salt_value
		password_digest = Digest::MD5::hexdigest salted_password
		return salt_value, password_digest
	end

	def valid_user?(user, password)
		salted_password = password + user.salt
		password_diggest = Digest::MD5::hexdigest salted_password
		password_diggest == user.password_diggest
	end
end