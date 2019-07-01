module Api
  module V1
    module InvoiceItems
      class SearchController < ApplicationController

        def show
          render json: InvoiceItemSerializer.new(InvoiceItem.find_by(invoice_item_params))
        end

        private

        def invoice_item_params
          params.permit(:id,
                        :item_id,
                        :invoice_id,
                        :quantity,
                        :unit_price,
                        :created_at,
                        :updated_at)
        end

      end
    end
  end
end
