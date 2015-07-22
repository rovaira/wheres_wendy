class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @current_location = CurrentLocation.where(user: params[:id])
  end
end
