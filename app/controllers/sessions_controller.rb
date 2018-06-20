class SessionsController < ApplicationController
  def new; end

  def create
    @customer = Customer.find_by email: params[:session][:email].downcase
    if @customer && @customer.authenticate(params[:session][:password])
      checkin
    else
      invalid_checkin
    end
  end

  def checkin
    if @customer.activated?
      log_in @customer
      params[:session][:remember_me] == Settings.checkbox_true ? remember(@customer) : forget(@customer)
      redirect_back_or @customer
    else
      flash[:warning] = t "flash_fail_actived"
      redirect_to root_path
    end
  end

  def invalid_checkin
    flash.now[:danger] = t "flash_invalid_danger"
    render :new
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
