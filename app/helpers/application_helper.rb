module ApplicationHelper
  def full_title page_title
    base_title = t "main_title"
    page_title.empty? ? base_title : "#{page_title} #{base_title}"
  end

  def load_room_type
    RoomType.all.map{|room| [room.name, room.id]}
  end
end
