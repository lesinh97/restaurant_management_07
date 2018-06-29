class Supports::Admins
  attr_reader :admin

  def booking_tickets
    @booking_tickets = BookingTicket.all
  end

  def customers
    @customers = Customer.all
  end

  def room_types
    @room_types = RoomType.all
  end

  def rooms
    @rooms = Room.all
  end
end

