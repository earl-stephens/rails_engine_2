module Api
  module V1
    module InvoiceItems
      class SearchController < ApplicationController

        def index
          if invoice_item_params[:unit_price]
            formatted_price = invoice_item_params[:unit_price].gsub('.', '')
            render json: InvoiceItemSerializer.new(InvoiceItem.where(unit_price: formatted_price))
          else
            render json: InvoiceItemSerializer.new(InvoiceItem.where(invoice_item_params))
          end
        end

        def show
          if invoice_item_params[:unit_price]
            formatted_price = invoice_item_params[:unit_price].gsub('.', '')
            render json: InvoiceItemSerializer.new(InvoiceItem.find_by(unit_price: formatted_price))
          else
            render json: InvoiceItemSerializer.new(InvoiceItem.find_by(invoice_item_params))
          end
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
