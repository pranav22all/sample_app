require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do 
	  	# Tests whether we are treating invalid signups properly and not adding to count 
	  	get signup_path 
	  	# We will not make sure that the number of Users remains the same even after we issue
	  	# this invalid test case 
	  	assert_no_difference 'User.count' do
	  		post users_path, params: { user: { name:  "",
	                                     email: "user@invalid",
	                                     password:              "foo",
	                                     password_confirmation: "bar" } }
		end
		#Above will return true if there is no difference 
		#Checks if returns users/new at the end
		assert_template 'users/new'
   end 
   #Test to make sure valid signups are actually added to database 
   test "valid signup information" do 
		get signup_path 
		#This is a block so we need to have an end after it for ruby 
		assert_difference 'User.count', 1 do 
			post users_path, params: { user: { name:  "Example User",
		                                         email: "user@example.com",
		                                         password:              "password",
		                                         password_confirmation: "password" } }
		end
		#Makes sure redirects to the proper page 
		follow_redirect!
		assert_template 'users/show'
	end  		   
end
