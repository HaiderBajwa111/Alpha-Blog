class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Successfully loged in"
      redirect_to user_path(user.id)
    else
      flash.now[:alert] = "Something went wronge in your login details"
      render 'new'
  end
end

  def destroy
    session[:user_id] = nil 
    flash[:notice] = "loged out"
    redirect_to root_path
  end 
end