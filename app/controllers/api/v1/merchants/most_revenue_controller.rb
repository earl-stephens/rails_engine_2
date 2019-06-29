module Api
  module V1
    module Merchants
      class MostRevenueController < ApplicationController

        def index
          quantity = params[:quantity]
          render json: MerchantSerializer.new(Merchant.sort_by_revenue(quantity))
        end

      end
    end
  end
end
