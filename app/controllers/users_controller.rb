class UsersController < ApplicationController
  
before_filter :save_login_state, :only => [:new, :create]  
  
#  def index
#    @users = User.all
#  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
#    if @user.save
#        redirect_to @user, alert: "User created successfully."
#    else
#        redirect_to new_user_path, notice: "Error creating user."
#    end

    if @user.save
      flash.now[:notice] = "You signed up successfully."
      #flash.now[:color]= "valid"
      redirect_to @user
    else
      flash.now[:notice] = "Something wrongly filled." 
      #flash.now[:color]= "invalid"
      render "new"
    end
    
    
#    if @user.save
#      redirect_to new_user_path
#    end 
  end
  
  def show
   @user = User.find(params[:id])
#   @name = params["name"]
#   @email = params["email"]
  end
  
  private
   def user_params
     params.require(:user).permit(:name, :email, :password, :password_confirmation, :username)
   end   
end
