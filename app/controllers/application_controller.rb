class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  private

  def location
    if params[:location].blank?
      if Rails.env.test? || Rails.env.development?
        @location ||= Geocoder.search("50.78.167.161").first
      else
        @location ||= request.location
      end
    else
      params[:location].each {|l| l = l.to_i } if params [:location].is_a? Array
      @location ||= Geocoder.search(params[:location]).first
      @location
    end
  end

  def locals(values)
    render locals: values
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(
        :email,
        :password,
        :password_confirmation,
        :first_name,
        :last_name,
        :class_year,
        :blurb,
        :phone,
        :share_phone,
        :location,
        :latitude,
        :longitude
        )
    end

    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(
        :email,
        :password,
        :password_confirmation,
        :first_name,
        :last_name,
        :class_year,
        :blurb,
        :phone,
        :share_phone,
        :location,
        :latitude,
        :longitude
        )
    end
  end
end
