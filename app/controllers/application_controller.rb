class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  private

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
        :current_password
        )
    end
  end
end
