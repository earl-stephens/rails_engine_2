module Api
  module V1
    class InvoiceCustomerController < ApplicationController

      def show
        render json: CustomerSerializer.new(Invoice.find(params[:invoice_id]).customer)
      end

    end
  end
end
