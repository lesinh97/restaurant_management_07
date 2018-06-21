class AccountActivationsController < ApplicationController
  def edit
    customer = Customer.find_by email: params[:email]
    if customer && !customer.activated? && customer.authenticated?(:activation, params[:id])
      customer.activate
      log_in customer
      flash[:success] = t "flash_actived"
      redirect_to customer
    else
      flash[:danger] = t "flash_fail_actived"
      redirect_to root_path
    end
  end
end
