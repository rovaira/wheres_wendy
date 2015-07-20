class CurrentLocationsController < ApplicationController
  def index
    if params[:search].present?
      current_locations = CurrentLocation.near(params[:search], 5)
      # current_location_markers(current_locations)
      locals current_locations: current_locations
    else
      current_locations = CurrentLocation.all
      # current_location_markers(current_locations)
      locals current_locations: current_locations
    end

  end

  def show
    @current_location = CurrentLocation.find(params[:id])
  end

  def new
    @current_location = CurrentLocation.new
  end

  def create
    @current_location = CurrentLocation.new(current_location_params)
    if @current_location.save
      redirect_to @current_location,
      notice: "Successfully created user location."
    else
      render :action => 'new'
    end
  end

  def edit
    @current_location = CurrentLocation.find(params[:id])
  end

  def update
    @current_location = CurrentLocation.find(params[:id])
    if @current_location.update_attributes(current_location_params)
      redirect_to @current_location,
      notice: "Successfully updated user's location."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @current_location = CurrentLocation.find(params[:id])
    @current_location.destroy
    redirect_to parks_url, notice: "Successfully destroyed user's location."
  end

  private

  def current_location_params
    params.require(:current_location).permit(:user_id, :address, :latitude,
    :longitude)
  end

  # def current_location_markers(current_locations)
  #   @hash = Gmaps4rails.build_markers(current_locations)
  # do |current_location, marker|
  #     marker.lat current_location.latitude
  #     marker.lng current_location.longitude
  #     marker.infowindow current_location.address
  #   end
  # end

end
