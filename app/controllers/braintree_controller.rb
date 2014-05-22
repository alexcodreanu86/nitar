class BraintreeController < ApplicationController
  def new_transaction
  end

  def submit_transaction
    result = Braintree::Transaction.sale(
      :amount => params[:amount],
      :credit_card => {
        :cardholder_name => params[:name],
        :number => params[:number],
        :cvv => params[:cvv],
        :expiration_month => params[:month],
        :expiration_year => params[:year]
      },
      billing: {
        :postal_code => params[:zip]
      },
      :options => {
        :submit_for_settlement =>  params[:charge]
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
