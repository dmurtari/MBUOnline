class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :correct_user]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :admin_user, only: [:destroy]
  before_action :already_signed_in, only: [:new]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to MBU Online!"
      redirect_to @user
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:warning] = "#{@user.firstname} was deleted"
    redirect_to users_url
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:firstname, :lastname, :troop, :district, :phone, :email,
                                   :password, :password_confirmation)
    end

    def correct_user
      unless current_user? @user
        redirect_to root_url
        flash[:danger] = "Sorry, you aren't authorized to perform that action"
      end
    end

    def already_signed_in
      if signed_in?
        flash[:info] = "You are already signed in"
        redirect_to root_url
      end
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
