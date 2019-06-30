module Api
  module V1
    class MerchantItemsController < ApplicationController

      def show
        render json: ItemSerializer.new(Merchant.find(params[:merchant_id]).items)
      end

    end
  end
end
