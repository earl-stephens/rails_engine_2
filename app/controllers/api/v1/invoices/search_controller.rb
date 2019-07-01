module Api
  module V1
    module Invoices
      class SearchController < ApplicationController

        def index
          render json: InvoiceSerializer.new(Invoice.order(:id).where(invoice_params))
        end

        def show
          render json: InvoiceSerializer.new(Invoice.find_by(invoice_params))
        end

        private

        def invoice_params
          params.permit(:id,
                        :customer_id,
                        :merchant_id,
                        :status,
                        :created_at,
                        :updated_at)
        end

      end
    end
  end
end
