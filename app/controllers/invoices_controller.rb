class InvoicesController < ApplicationController
  before_action :logged_in_customer
  before_action :load_invoice

  def index
    load_invoice
  end

  def show
    @invoice = Invoice.find_by id: params[:id]
    redirect_to invoices_path unless @invoice
    @customer = @invoice.customer
    return unless @customer
    @booking_ticket = @invoice.booking_ticket
    return unless @booking_ticket
  end

  def new
    @invoice = Invoice.new
    @booking_ticket = BookingTicket.find_by id: params[:booking_ticket_id]
    return unless @booking_ticket
    @customer = Customer.find_by id: params[:customer_id]
    return unless @customer
    @invoice.assign_attributes total: params[:total]
  end

  def create
    Invoice.transaction do
      @invoice = Invoice.new invoice_params
      if @invoice.save
        flash[:success] = t "invoice_create"
      else
        flash[:danger] = t "invoice_not_create"
      end
      redirect_to invoices_path
    end
  end

  private

  def load_invoice
    @invoices = if current_customer.admin?
                  Invoice.newest.paginate page: params[:page],
                    per_page: Settings.invoice_per_page
                else
                  current_customer.invoices.newest.paginate page: params[:page],
                    per_page: Settings.invoice_per_page
                end
    return if @invoices
  end

  def invoice_params
    params.require(:invoice).permit :booking_ticket_id, :customer_id, :total
  end
end
