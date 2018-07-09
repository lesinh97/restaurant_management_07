class BookingTicketsController < ApplicationController
  before_action :logged_in_customer
  before_action :load_booking_ticket
  before_action :load_invidual_ticket, only: %i(change_status cancel destroy)
  before_action :load_room_type, only: :create
  before_action :load_customer_list, only: :index
  def index
    if params[:search]
      query_search
      respond_to do |format|
        format.html
        format.js
      end
    else
      load_booking_ticket
    end
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
      status = @ticket.destroy ? :success : :danger
      flash[status] = t ".#{status}"
      format.html{render :index}
    end
  end

  def change_status
    if @ticket.update_attributes(status: :accetped) && @ticket.room.update_attributes(available: false)
      flash.now[:success] = t "success_change_status"
    else
      flash.now[:danger] = t "fail_change_status"
    end
    respond_to do |format|
      format.html{render :index}
    end
  end

  def cancel
    if @ticket.update_attributes(status: :cancel) && @ticket.room.update_attributes(available: true)
      flash[:success] = t "cancel_success"
    else
      flash[:danger] = t "cancel_fail"
    end
    redirect_to booking_tickets_path
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
    end
  end

  def load_room_type
    @room_types = RoomType.newest
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
    return unless @booking_ticket.update_attributes stay_day_number: stay_day_number
    total_price = calculate_total_price(@booking_ticket).to_f
    return unless @booking_ticket.update_attributes total_price: total_price
    return unless current_customer.update_attributes total_booking: caculate_total_booking(current_customer)
    redirect_to booking_tickets_path
    flash.now[:success] = t "book_successful"
  end

  def query_search
    @booking_tickets = BookingTicket.search_by_customer_name(params[:search]).paginate page: params[:page],
                        per_page: Settings.booking_per_page
  end
end
