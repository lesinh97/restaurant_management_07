class AdminsController < ApplicationController
  before_action :admin_customer, :logged_in_customer

  def index
    @supports = Supports::Admins.new
  end
end
