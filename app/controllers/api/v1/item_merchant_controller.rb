module Api
  module V1
    class ItemMerchantController < ApplicationController

      def show
        render json: MerchantSerializer.new(Item.find(params[:item_id]).merchant)
      end

    end
  end
end
