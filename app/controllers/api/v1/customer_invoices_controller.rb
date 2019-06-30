module Api
  module V1
    class CustomerInvoicesController < ApplicationController

      def show
        render json: InvoiceSerializer.new(Customer.find(params[:customer_id]).invoices)
      end

    end
  end
end
