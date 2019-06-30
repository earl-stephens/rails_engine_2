module Api
  module V1
    class CustomerTransactionsController < ApplicationController

      def show
        customer1 = Customer.find(params[:customer_id])
        render json: TransactionSerializer.new(customer1.get_transactions)
      end

    end
  end
end
