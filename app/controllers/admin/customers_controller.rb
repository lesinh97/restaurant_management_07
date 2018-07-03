module Admin
  class CustomersController < AdminsController
    before_action :admin_customer, only: %i(destroy index)

    def index
      @customers = Customer.all.paginate page: params[:page], per_page: Settings.customer_per_page
    end

    def destroy
      @customer = Customer.find_by id: params[:id]
      flash = @customer.destroy ? :success : :danger
      flash[flash] = t "destroy.#{flash}"
    end
  end
end
