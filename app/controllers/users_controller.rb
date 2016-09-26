class UsersController < ApplicationController
  def user_params
    params.require(:user).permit(:user_id, :email, :session_token, :timestamps)
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
    @user=User.create_user!(params[:user])

      if !!(@user)
      flash[:notice] = "New user #{@user.user_id} was successfully created."
      redirect_to movies_path
    else
      flash[:notice] = "The User Id #{params[:user][:user_id]} already exists"
      redirect_to new_user_path
    end
  end
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    @user.update_attributes!(user_params)
    flash[:notice] = "#{@user.email} was successfully updated."
    redirect_to user_path(@user)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "User '#{@user.email}' deleted."
    redirect_to users_path
  end