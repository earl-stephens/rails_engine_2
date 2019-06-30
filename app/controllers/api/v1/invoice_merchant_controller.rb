module Api
  module V1
    class InvoiceMerchantController < ApplicationController

      def show
        render json: MerchantSerializer.new(Invoice.find(params[:invoice_id]).merchant)
      end

    end
  end
end
