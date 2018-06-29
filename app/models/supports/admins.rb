module Supports
  class Admins
    attr_reader :admin

    def load_booking_tickets
      @booking_tickets = BookingTicket.newest
    end

    def load_customers
      @customers = Customer.newest
    end

    def load_room_types
      @room_types = RoomType.newest
    end

    def load_rooms
      @rooms = Room.newest
    end

    def load_invoices
      @invoices = Invoice.newest
    end
  end
end
