module Api
  module V1
    class TransactionInvoicesController < ApplicationController

      def show
        render json: InvoiceSerializer.new(Transaction.find(params[:transaction_id]).invoice)
      end

    end
  end
end
