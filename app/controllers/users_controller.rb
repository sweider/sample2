class UsersController < ApplicationController
  before_filter :autorizate!, only: [:edit, :update]

  def new
    @user = User.new
  end

  def show 
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to user_path(@user)
    else
      render action: "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      flash[:success] = "Successfully updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end


  private 
    def autorizate!
      redirect_to sign_in_path, notice: "Please, sign in" unless signed_in?
    end
end
