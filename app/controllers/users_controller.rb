class UsersController < ApplicationController

  # def new
  #   @user = User.new
  # end
  #
  # def create
  #   @user = User.new(user_params)
  #   CurrentLocation.new(user_id: current_user.id)
  #   if @user.save
  #     redirect_to @user,``
  #       flash[:notice] = "Successfully created user location."
  #   else
  #     render :action => 'new'
  #   end
  # end

  def destroy
    if current_user.try(:admin?)
      @user = User.find(params[:id])
      @user.destroy
      flash[:notice] = "User deleted"
      redirect_to users_path
    end
  end

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
      if @user.update(user_params)
        flash[:notice] = "Profile updated."
        redirect_to user_path(@user)
      else
        flash[:notice] = @user.errors.full_messages.join(".  ")
        render :edit
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :class_year, :blurb, :phone, :share_phone)
  end
end
