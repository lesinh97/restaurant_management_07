class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_customer
    return if logged_in?
    store_location
    flash[:danger] = t "flash_not_login"
    redirect_to login_path
  end

  def admin_customer
    redirect_to root_path unless current_customer.admin?
  end
end
