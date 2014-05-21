class BraintreeController < ApplicationController
  def new_transaction
  end

  def submit_transaction
    result = Braintree::Transaction.sale(
      :amount => "1000.00",
      :credit_card => {
        :number => params[:number],
        :cvv => params[:cvv],
        :expiration_month => params[:month],
        :expiration_year => params[:year]
      },
      :options => {
        :submit_for_settlement => true
      }
    )
    if result.success?
      flash[:notice] = "Great success!"
      redirect_to root_path
    else
      flash[:alert] = "Failed"
      redirect_to :back
    end
  end
end
