class CurrentLocationsController < ApplicationController
  def index
    authenticate_user!

    if params[:search].present?
      current_locations = CurrentLocation.near(params[:search], 5)
      current_location_markers(current_locations)
      locals current_locations: current_locations
    else
      current_locations = CurrentLocation.where.not(user_id: current_user)
      current_location_markers(current_locations)
      locals current_locations: current_locations
    end
  end

  def new
    @current_location = CurrentLocation.new
  end

  def create
    @current_location = CurrentLocation.new(current_location_params)
    if @current_location.save
      redirect_to @current_location,
        flash[:notice] = "Successfully created user location."
    else
      render :action => 'new'
    end
  end

  def edit
    @current_location = CurrentLocation.find(params[:id])
  end

  def update
    json_hash = JSON.parse(params.first[0])
    found_address = address(json_hash)
    json_hash["address"] = found_address

    if CurrentLocation.find_by(user_id: current_user.id) == nil
      CurrentLocation.create(user_id: current_user.id)
    end

    @current_location = CurrentLocation.find_by(user_id: current_user.id)
    if @current_location.update_attributes(json_hash)
      flash[:notice] = "Successfully updated your location."

      respond_to do |format|
        format.html
        format.json { render nothing: true, status: 200 }
      end
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

  def address(json_hash)
    lat = json_hash["latitude"].to_s
    long = json_hash["longitude"].to_s
    address_string = lat + ", " + long
    Geocoder.address(address_string)
  end

  def current_location_markers(current_locations)
    @hash = Gmaps4rails.build_markers(current_locations) do |current_location, marker|
      infowindow = %{
      #{current_location.user.first_name} #{current_location.user.last_name} \n
      #{current_location.user.class_year}
    }
      marker.lat current_location.latitude
      marker.lng current_location.longitude
      marker.infowindow(infowindow)
    end
  end
end
