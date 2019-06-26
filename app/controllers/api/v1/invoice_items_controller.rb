module Api
  module V1
    class InvoiceItemsController < ApplicationController

      def index
        render json: InvoiceItemSerializer.new(InvoiceItem.all)
      end

      def show
        render json: InvoiceItemSerializer.new(InvoiceItem.find(params[:id]))
      end

    end
  end
end
