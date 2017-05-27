require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  # We will use this michael user across different tests
  def setup
  	@user = users(:michael)
  end 
  test "login with invalid info" do
 	get login_path 
 	assert_template 'sessions/new'
 	#Makes sure we go to sessions/new upon getting the login_path 
 	post login_path, params: {session: {email: "", password: ""}}
 	#Post to the login form, the following invalid criteria 
 	assert_template 'sessions/new'
 	#Makes sure we are redirected to the new page
 	assert_not flash.empty? 
 	#Makes sure there is a flash present (double neg)
 	get root_path 
 	#Makes sure no flash present one page further
 	assert flash.empty? 
  end
  test "login with valid information" do
  	get login_path 
  	post login_path, params: {session: {email: @user.email,
  										password: 'password'} }
  	#Checks if we are redirected to the user page 
  	assert_redirected_to @user 
  	#Actually follow through and visits the target page (! is necessary)
  	follow_redirect!
  	assert_template 'users/show'
  	#0 links to login
  	assert_select "a[href=?]", login_path, count: 0 
  	assert_select "a[href=?]", logout_path
  	#Tests for the profile link
  	assert_select "a[href=?]", user_path(@user)
  end
  test "login with valid info followed by a logout" do 
  	get login_path 
  	post login_path, params: {session: {email: @user.email,
  										password: 'password'} }
  	#Helper method 
  	assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user) 	  	
    #This issues a DELETE request to the logout path
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
end
	
