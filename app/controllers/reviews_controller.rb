class ReviewsController < ApplicationController
  before_action :logged_in_customer, only: %i(create destroy)
  before_action :review_destroy, only: :destroy
  before_action :review_create, only: :create

  def create
    respond_to do |format|
      if @review.save
        format.html{redirect_to @room}
        format.js
      else
        flash[:danger] = t "review_failed"
        format.html{redirect_to @room}
      end
    end
  end

  def destroy
    respond_to do |format|
      if @review.destroy
        format.html{redirect_to @room}
        format.js
      else
        flash[:danger] = t "delete_failed_review"
        format.html{redirect_to @room}
      end
    end
  end

  private

  def review_destroy
    @review = if current_customer.admin?
                Review.find_by id: params[:id]
              else
                current_customer.reviews.find_by id: params[:id]
              end
    flash[:danger] = t "no_review" if @review.blank?
    @room = @review.room
  end

  def review_create
    @room = Room.find_by id: params[:review][:room_id]
    if @room
      @review = @room.reviews.build review_params
    else
      flash[:danger] = t "load_room_failed"
      redirect_to rooms_path
    end
  end

  def review_params
    params.require(:review).permit :room_id, :content, :customer_id
  end
end
