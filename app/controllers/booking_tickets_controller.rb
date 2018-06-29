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
      initializer_constance
      check_available_room
      if @booking_ticket.save
        handle_booking_successful
      else
        render :new
      end
    end
  end

  def destroy
    respond_to do |format|
      status = @room.deleted! ? :success : :danger
      flash[status] = t ".destroy.#{status}"
      format.html{redirect_to booking_tickets_path}
    end
  end

  private

  def initializer_constance
    @booking_ticket = current_customer.booking_tickets.build booking_ticket_params
    @room_type = RoomType.find_by id: params[:room_type_id]
    @rooms = @room_type.rooms.is_available
  end

  def check_available_room
    if @rooms.present?
      @rooms[0].booking_tickets << @booking_ticket
    else
      flash[:danger] = t "no_room_available"
      render :new
    end
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
    @booking_ticket.update_attributes stay_day_number: stay_day_number,
      total_price: calculate_total_price(@booking_ticket)
    current_customer.update_attributes total_booking: caculate_total_booking(current_customer)
    redirect_to booking_tickets_path
    flash.now[:success] = t "book_successful"
  end
end
