module Admin
  class RoomsController < AdminsController
    before_action :admin_customer, except: %i(index show)

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

    def edit; end

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
  end
end
