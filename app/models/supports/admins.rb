module Supports
  class Admins
    attr_reader :admin

    def load_booking_tickets
      @booking_tickets = BookingTicket.all.odering
    end

    def load_customers
      @customers = Customer.all.odering
    end

    def load_room_types
      @room_types = RoomType.all.odering
    end

    def load_rooms
      @rooms = Room.all.odering
    end
  end
end
