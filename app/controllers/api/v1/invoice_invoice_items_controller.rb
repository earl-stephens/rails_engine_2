module Api
  module V1
    class InvoiceInvoiceItemsController < ApplicationController

      def show
        render json: InvoiceItemSerializer.new(Invoice.find(params[:invoice_id]).invoice_items)
      end

    end
  end
end
