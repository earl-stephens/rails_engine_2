module Api
  module V1
    class InvoiceItemInvoicesController < ApplicationController

      def show
        render json: InvoiceSerializer.new(InvoiceItem.find(params[:invoice_item_id]).invoice)
      end

    end
  end
end
