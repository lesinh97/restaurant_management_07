class BookingTicketsController < ApplicationController
  before_action :logged_in_customer
  before_action :load_booking_ticket
  def index
    load_booking_ticket
  end

  def show; end

  def new
    @booking_ticket = current_customer.booking_tickets.new customer_id: params[:customer_id].to_i
    @room_types = RoomType.all
  end

  def create
    BookingTicket.transaction do
      @booking_ticket = current_customer.booking_tickets.build booking_ticket_params
      if @booking_ticket.save
        handle_booking_successful
        @booking_ticket.update_attributes(total_price: calculate_total_price(@booking_ticket))
        current_customer.update_attributes(total_booking: caculate_total_booking(current_customer))
      else
        render :new
      end
    end
  end

  private

  def load_booking_ticket
    @booking_tickets = if current_customer.admin?
                         BookingTicket.odering.paginate page: params[:page],
                           per_page: Settings.booking_per_page
                       else
                         current_customer.booking_tickets.odering.paginate page: params[:page],
                           per_page: Settings.booking_per_page
                       end
    return if @booking_tickets
    redirect_to new_booking_ticket_path
  end

  def booking_ticket_params
    params.require(:booking_ticket).permit :room_id, :start_day, :end_day
  end

  def caculate_stay_day booking_ticket
    (booking_ticket.end_day.to_date - booking_ticket.start_day.to_date).to_i
  end

  def caculate_total_booking customer
    customer.booking_tickets.size
  end

  def handle_booking_successful
    stay_day_number = caculate_stay_day @booking_ticket
    @booking_ticket.room.update_attributes available: false
    @booking_ticket.update_attributes stay_day_number: stay_day_number
    redirect_to booking_tickets_path
    flash.now[:success] = t "book_successful"
  end
end
