module ApplicationHelper
  def full_title page_title
    base_title = t "main_title"
    page_title.empty? ? base_title : "#{page_title} #{base_title}"
  end

  def load_room_type room_type
    room_type.map{|room| [room.name, room.id. room.room_id]}
  end

  def load_room_number doom
    doom.map{|es| [es.room_numb, es.id]}
  end

  def display_time_in_booking time
    time.strftime(Settings.date_time_format)
  end
end
