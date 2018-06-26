module ApplicationHelper
  def full_title page_title
    base_title = t "main_title"
    page_title.empty? ? base_title : "#{page_title} #{base_title}"
  end

  def load_room_type
    RoomType.all.map{|room| [room.name, room.id]}
  end

  def load_room_number doom
    doom.map{|es| [es.room_numb, es.id]}
  end

  def display_time_in_booking time
    time.strftime(Settings.date_time_format)
  end

  def caculate_price a, b
    a * b
  end
end
