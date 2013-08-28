class UsersController < ApplicationController
  before_filter :autorizate!, only: [:edit, :update, :index, :destroy]
  before_filter :correct_user?, only: [:edit, :update]
  before_filter :admin_check, only: [:destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

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
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Successfully updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end


  private 
    def autorizate!
      unless signed_in?
        store_location
        redirect_to sign_in_path, notice: "Please, sign in"
      end 
    end

    def correct_user?
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_check
      redirect_to root_path unless current_user.admin?
    end
end
