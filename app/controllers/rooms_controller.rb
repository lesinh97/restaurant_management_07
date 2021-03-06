class RoomsController < ApplicationController
  before_action :logged_in_customer, except: %i(new create update)
  before_action :admin_customer, except: %i(show index)
  before_action :load_room, only: %i(show)

  def index
    @rooms = Room.newest.includes(:room_type).paginate page: params[:page], per_page: Settings.room_per_page
  end

  def show; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def load_room
    @room = Room.find_by id: params[:id]
    return if @room
    redirect_to rooms_path
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def room_params
    params.require(:room).permit :room_numb, :position, :description, :available,
      :room_type_id
  end
end
