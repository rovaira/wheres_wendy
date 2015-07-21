class CurrentLocationsController < ApplicationController
  before_action :authenticate_user!

  def index
    # if params[:search].present?
    #   current_locations = CurrentLocation.near(params[:search], 5)
    #   # current_location_markers(current_locations)
    #   locals current_locations: current_locations
    # else
    #   current_locations = CurrentLocation.all
    #   # current_location_markers(current_locations)
    #   locals current_locations: current_locations
    # end
    @current_locations = CurrentLocation.where.not(user_id: current_user)
    @hash = Gmaps4rails.build_markers(@current_locations) do |current_location, marker|
      infowindow = %{
      #{current_location.user.first_name} #{current_location.user.last_name} \n
      #{current_location.user.class_year}
    }
      marker.lat current_location.latitude
      marker.lng current_location.longitude
      marker.infowindow(infowindow)
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
    json_hash = JSON.parse(params.first[0])
    # current_user = User.find(current_user.id)
    # current_location = CurrentLocation.find_or_create_by(current_user.id)

    @current_location = CurrentLocation.find_or_create_by(user_id: params[:id])
    if @current_location.update_attributes(json_hash)
      redirect_to @current_location,
        notice: "Successfully updated user's location."
    else
      render action: 'edit'
    end
  end

  def destroy
    @current_location = CurrentLocation.find(params[:id])
    @current_location.destroy
    redirect_to parks_url, notice: "Successfully destroyed user's location."
  end

  def geocode
    position = Geocoder.coordinates(params[:query])
    respond_to do |wants|
      wants.json { render :json => position }
    end
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
