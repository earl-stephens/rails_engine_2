module Api
  module V1
    module Merchants
      class MostItemsController < ApplicationController

        def index
            quantity = params[:quantity]
            render json: MerchantSerializer.new(Merchant.sort_by_most_items(quantity))
        end

      end
    end
  end
end
