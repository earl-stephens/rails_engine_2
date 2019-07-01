module Api
  module V1
    module Items
      class SearchController < ApplicationController

        def show
          render json: ItemSerializer.new(Item.find_by(item_params))
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
