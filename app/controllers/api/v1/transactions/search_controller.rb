module Api
  module V1
    module Transactions
      class SearchController < ApplicationController

        def index
          render json: TransactionSerializer.new(Transaction.order(:id).where(transaction_params))
        end

        def show
          render json: TransactionSerializer.new(Transaction.find_by(transaction_params))
        end

        private

        def transaction_params
          params.permit(:id,
                        :invoice_id,
                        :credit_card_number,
                        :result,
                        :created_at,
                        :updated_at)
        end

      end
    end
  end
end
