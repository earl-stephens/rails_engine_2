module Api
  module V1
    class ItemInvoiceItemsController < ApplicationController

      def show
        render json: InvoiceItemSerializer.new(Item.find(params[:item_id]).invoice_items)
      end

    end
  end
end
