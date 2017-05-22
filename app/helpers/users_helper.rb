module UsersHelper
	def gravatar_for(user)
		# Creates a URL based off of a MD5 hash of the user's email
		# the gravatar it gets is the one you associate with your email already 
	    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
	    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
	    #will return this image (Gravatar) from the URL 
	    image_tag(gravatar_url, alt: user.name, class: "gravatar")		
	end 
end
