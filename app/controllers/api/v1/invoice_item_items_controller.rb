module Api
  module V1
    class InvoiceItemItemsController < ApplicationController

      def show
        render json: ItemSerializer.new(InvoiceItem.find(params[:invoice_item_id]).item)
      end

    end
  end
end
