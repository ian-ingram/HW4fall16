class SessionsController < ApplicationController
    
    #new, create and destroy
  def new
    # default: render 'new' template
  end

  def create
    id=params[:user][:user_id]
    email=params[:user][:email]
    user=User.find_by user_id: id
    if(User.exists?(user) && user != nil)
        session[:session_token] = user.session_token
        flash[:notice] = "You are logged in as #{user.user_id}"
        flash[:class]= "flash_message"
        redirect_to movies_path
    else
        flash[:notice] = "Invalid username or password"
        flash[:class]= "flash_message"
        redirect_to login_path
    end
  end

  def destroy
    session[:session_token] = nil
    redirect_to movies_path
  end
    
end