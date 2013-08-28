class SessionsController < ApplicationController

  def new
    
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:success] = "Welcome, #{user.name}!"
      sign_in(user)
      redirect_back_or user
    else
      flash.now[:error] = "Invalid combination email + password"
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  
end
