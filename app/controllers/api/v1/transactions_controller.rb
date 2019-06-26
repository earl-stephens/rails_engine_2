module Api
  module V1
    class TransactionsController < ApplicationController

      def index
        render json: TransactionSerializer.new(Transaction.all)
      end

      def show
        render json: TransactionSerializer.new(Transaction.find(params[:id]))
      end

    end
  end
end
