module Api
  module V1
    class InvoiceRelatedItemsController < ApplicationController

      def show
        invoice1 = Invoice.find(params[:invoice_id])
        render json: ItemSerializer.new(Invoice.find(params[:invoice_id]).items)
      end

    end
  end
end
