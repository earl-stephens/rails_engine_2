module Api
  module V1
    class RevenueController < ApplicationController

      def show
        merch_id = params[:merchant_id]
        data = RevenueSerializer.new(merch_id).get_data
        render json: data
      end

    end
  end
end
