class ApplicationController < ActionController::Base
  before_filter :configure_parameters, :if => :devise_controller?
  protect_from_forgery with: :exception

  private

  def current_admin?
    current_user && current_user.is_admin
  end

  def configure_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit :email, :password, :password_confirmation, :name, :phone
    end
  end
end
