module SessionsHelper
#Deals with a single user session (keeping them logged in between pages)
	def log_in(user)
		#upon a successful login, the session adopts the user id 
		session[:user_id]= user.id 
	end
	def current_user 
		# session[:user_id] will be nil for non-logged in users
		#if @current_user is nil, than sets current_user = User.find_by(...)
		@current_user ||= User.find_by(id: session[:user_id])
	end 
	#? after method names that return a boolean 
	def logged_in? 
		#Runs the current_user method, if it's nil returns false, else returns true 
		!current_user.nil? 
	end
	def log_out
		# Destroys the user_id implemented from log_in
		# We will call this method in the Sessions Controller under the destroy action
		session.delete(:user_id)
		@current_user = nil 
	end 
end
