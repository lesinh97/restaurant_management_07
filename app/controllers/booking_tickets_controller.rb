class BookingTicketsController < ApplicationController
  before_action :load_booking_ticket, except: %i(new create index)

  def index
    @booking_tickets = current_customer.booking_tickets.odering
  end

  def show; end

  def new
    @booking_ticket = current_customer.booking_tickets.new customer_id: params[:customer_id].to_i
  end

  def create
    @booking_ticket = current_customer.booking_tickets.build booking_ticket_params
    if @booking_ticket.save
      redirect_to @booking_ticket
    else
      render :new
    end
  end

  private

  def load_booking_ticket
    @booking_ticket = BookingTicket.find_by id: params[:id]
    return if @booking_ticket
    redirect_to root_path
  end

  def booking_ticket_params
    params.require(:booking_ticket).permit :customer_id, :room_id, :start_day, :last_day
  end
end
