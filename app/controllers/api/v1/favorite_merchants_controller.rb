module Api
  module V1
    class FavoriteMerchantsController < ApplicationController

      def show
        # binding.pry
        customer = Customer.find(params[:customer_id])
        render json: MerchantSerializer.new(customer.favorite_merchant)
      end

    end
  end
end
