module SessionHelper
	def is_user_session_exists?
		(session[:user_id] != nil)
	end
end