class SessionsController < ApplicationController
  def new; end

  def create
    if params[:session].present?
      nomarl_login
    else
      auth_login
    end
  end

  def destroy
    log_out if logged_in?
    session[:customer_id] = nil
    redirect_to root_path
  end

  private

  def checkin
    if @customer.activated?
      log_in @customer
      params[:session][:remember_me] == Settings.checkbox_true ? remember(@customer) : forget(@customer)
      redirect_back_or @customer
      flash[:primary] = t "log_in_success"
    else
      flash[:warning] = t "flash_fail_actived"
      redirect_to root_path
    end
  end

  def invalid_checkin
    flash.now[:danger] = t "flash_invalid_danger"
    render :new
  end

  def nomarl_login
    @customer = Customer.find_by email: params[:session][:email].downcase
    if @customer && @customer.authenticate(params[:session][:password])
      checkin
    else
      invalid_checkin
    end
  end

  def auth_login
    bridge = request.env["omniauth.auth"]
    auth_email = bridge.info[:email]
    @customer = Customer.find_by email: auth_email.downcase
    if @customer.present?
      log_in @customer
      redirect_to @customer
    else
      redirect_to controller: :customers, action: :new, name: bridge.info.name,
        email: bridge.info.email
    end
  end
end
