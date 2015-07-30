class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @current_location = CurrentLocation.where(user: params[:id])
    @ping = Ping.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if (current_user && current_user.id == @user.id)
      if @user.update_attributes(user_params)
        flash[:notice] = "Profile updated."
        redirect_to user_path(@user)
      else
        flash[:notice] = @user.errors.full_messages.join(".  ")
        redirect_to user_path(@user)
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :class_year, :blurb, :phone, :share_phone)
  end
end
