module Api
  module V1
    module Items
      class SearchController < ApplicationController

        def index
          if item_params[:unit_price]
            formatted_price = item_params[:unit_price].gsub('.', '')
            render json: ItemSerializer.new(Item.where(unit_price: formatted_price))
          else
            render json: ItemSerializer.new(Item.order(:id).where(item_params))
          end
        end

        def show
          if item_params[:unit_price]
            formatted_price = item_params[:unit_price].gsub('.', '')
            render json: ItemSerializer.new(Item.order(:id).find_by(unit_price: formatted_price))
          else
            render json: ItemSerializer.new(Item.order(:id).find_by(item_params))
          end
        end

        private

        def item_params
          params.permit(:id,
                        :name,
                        :description,
                        :unit_price,
                        :merchant_id,
                        :created_at,
                        :updated_at)
        end

      end
    end
  end
end
