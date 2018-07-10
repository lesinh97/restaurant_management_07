module Admin
  class RoomsController < AdminsController
    before_action :admin_customer, except: %i(index show)
    before_action :load_invidual_room, only: %i(edit change_status update)

    def new
      @room = Room.new
      @room_types = RoomType.all
    end

    def create
      @room = Room.new room_params
      if @room.save
        flash[:success] = t "create_room_success"
        redirect_to @room
      else
        render :new
      end
    end

    def edit
      @room_types = RoomType.all
    end

    def update
      if @room.update_attributes room_params
        flash[:success] = t "update_room_success"
        redirect_to @room
      else
        render :edit
      end
    end

    def destroy
      status = @room.deleted! ? :success : :danger
      flash[status] = t ".destroy.#{status}"
      redirect_to root_path
    end

    def change_status
      if @room.available?
        available_status
      else
        not_available_status
      end
      respond_to do |format|
        format.html{redirect_to rooms_path}
      end
    end

    def available_status
      if @room.update_attributes(available: false)
        flash[:success] = t "success_room_change_status"
      else
        flash[:danger] = t "fail_room_change_status"
      end
    end

    def not_available_status
      if @room.update_attributes(available: true)
        flash[:success] = t "success_room_change_status"
      else
        flash[:danger] = t "fail_room_change_status"
      end
    end

    private

    def load_invidual_room
      @room = Room.find_by id: params[:id]
      return if @room
      flash[:success] = t "no_room_found"
    end

    def room_params
      params.require(:room).permit :room_id, :room_numb, :position, :description, :available,
        :room_type_id
    end
  end
end
