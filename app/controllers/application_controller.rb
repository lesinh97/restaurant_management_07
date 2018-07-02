class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :caculate_price, :calculate_total_price
  include SessionsHelper
  include ActionView::Helpers::NumberHelper

  def logged_in_customer
    return if logged_in?
    store_location
    flash[:danger] = t "flash_not_login"
    redirect_to login_path
  end

  def admin_customer
    redirect_to root_path unless current_customer.admin?
  end

  def caculate_price a, b
    a * b
  end

  def calculate_total_price booking_ticket
    caculate_price booking_ticket.room.room_type.price.to_f, booking_ticket.stay_day_number.to_f
  end
end
