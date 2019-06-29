module Api
  module V1
    class RevenueController < ApplicationController

      def show
        merch_id = params[:merchant_id]
        date = params[:date] if params[:date]
        data = RevenueSerializer.new(merch_id, date).get_data
        # binding.pry
        render json: data
      end

    end
  end
end
