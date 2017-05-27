class SessionsController < ApplicationController
  def new
  	#for as soon as someone arrives on the pages 
  end
  def create 
  	# For once someone hits the login button (submits)
  	#We will be searching the User databased by the email column, 
  	#the email we are searching for is the one typed in;
  	user = User.find_by(email: params[:session][:email].downcase)
  	#.authenticate is provided under has_secure_password !
  	if user && user.authenticate(params[:session][:password])
  		#Log the user in and redirect to desired page 
  		#uses our method from sessions helper with parameter user
  		log_in user 
  		#Rails automatically takes this to mean to route user_url(user) [user profile page]
  		redirect_to user 
  	else
  		#flash already styled in our CSS 
  		flash.now[:danger] = "Invalid email/password combination" 
  		render 'new'
  		#Problem is that a render doesn't count as a request (redirects count as requests), thus
  		#the flash stays on the page one page longer than it should be  
  		#To fix this prblm, we use flash.now which makes flash disappear after add. requests
  	end 
  # Gives us / Renders the "new" view (new.html.erb)
  end 
  def destroy 
  	#Calls the log_out session helper method 
  	log_out
  	#redirects to the site's root_url from the routes.rb
  	redirect_to root_url
  end 
end
