module Api
  module V1
    class FavoriteCustomersController < ApplicationController

      def show
        data = FavoriteCustomerSerializer.new(params[:merchant_id]).get_data
        render json: data
      end

    end
  end
end
