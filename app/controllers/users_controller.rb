class UsersController < ApplicationController
  def show 
  	@user = User.find(params[:id])

  end 
  def new
  	@user = User.new
  end
  def create
    # params[:user] is a hash of the user attributes
    #user_params is our private method that we are calling to prevent database attacks  
    @user = User.new(user_params)    
    if @user.save
      # Handle a successful save
      # flash = message the appears just once on subseq page (not for reloads)
      # We still need to HTML / CSS and give style instructions to this flash though
      flash[:success] = "Welcome to the Sample App!"
      # Automatically redirects us to the User URL 
      #Equivalent to using redirect_to user_url(@user)
      redirect_to @user 
    else
      render 'new'
    end
  end

  private 
  	def user_params 
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end
end
