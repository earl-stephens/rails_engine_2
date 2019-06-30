module Api
  module V1
    class InvoiceTransactionsController < ApplicationController

      def show
        render json: TransactionSerializer.new(Invoice.find(params[:invoice_id]).transactions)
      end

    end
  end
end
