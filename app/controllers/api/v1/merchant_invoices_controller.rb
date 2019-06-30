module Api
  module V1
    class MerchantInvoicesController < ApplicationController

      def show
        render json: InvoiceSerializer.new(Merchant.find(params[:merchant_id]).invoices)
      end

    end
  end
end
