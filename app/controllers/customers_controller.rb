class CustomersController < ApplicationController
  def new
    @customer = Customer.new
    @customer.assign_attributes name: params[:name], email: params[:email]
  end

  def show
    load_customer
  end

  def create
    @customer = Customer.new customer_params
    if @customer.save
      @customer.send_activation_email
      flash[:info] = t "active_mail_info"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def load_customer
    @customer = Customer.find_by id: params[:id]
    return if @customer
    flash.now[:danger] = t ".nil_customer"
    redirect_to root_path
  end

  def customer_params
    params.require(:customer).permit :name, :email, :phone, :password,
      :password_confirmation
  end
end
