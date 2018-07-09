class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :caculate_price, :calculate_total_price, :load_booking_ticket,
    :load_invidual_ticket, :load_customer_list
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

  def load_booking_ticket
    @booking_tickets = if current_customer.admin?
                         BookingTicket.newest.paginate page: params[:page],
                          per_page: Settings.booking_per_page
                       else
                         current_customer.booking_tickets.newest.paginate page: params[:page],
                          per_page: Settings.booking_per_page
                       end
    return if @booking_tickets
    redirect_to new_booking_ticket_path
  end

  def load_invidual_ticket
    @ticket = BookingTicket.find_by id: params[:id]
    redirect_to booking_tickets_path unless @ticket
  end

  def load_customer_list
    @customer_list = if current_customer.admin?
                       Customer.atoz.pluck :name, :id
                     else
                       current_customer
                     end
  end
end
