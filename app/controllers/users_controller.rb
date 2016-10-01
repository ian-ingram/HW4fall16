class UsersController < ApplicationController

  def user_params
    params.require(:user).permit(:user_id, :email, :session_token)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @user = User.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @users = User.all
  end

  def new
    # default: render 'new' template
  end

  def create
    if((User.find_by user_id: params[:user][:user_id])==nil)
      @user = User.create_user!(params)
      flash[:notice] = "Welcome #{@user.user_id}. Your account has been created"
      flash[:class]= "flash_message"
      #redirect_to movies_path
      redirect_to login_path
    else
      flash[:notice] = "Sorry this user-id is taken. Try again."
      flash[:class]= "flash_message"
      redirect_to new_user_path
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    @user.update_attributes!(user_params)
    flash[:notice] = "#{@user.email} was successfully updated."
    flash[:class]= "flash_message"
    redirect_to user_path(@user)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "User '#{@user.email}' deleted."
    flash[:class]= "flash_message"
    redirect_to users_path
  end
end
