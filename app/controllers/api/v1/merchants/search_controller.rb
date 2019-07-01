module Api
  module V1
    module Merchants
      class SearchController < ApplicationController

        def index
          render json: MerchantSerializer.new(Merchant.where(merchant_params))
        end

        def show
          render json: MerchantSerializer.new(Merchant.find_by(merchant_params))
        end

        private

        def merchant_params
          params.permit(:id, :name, :created_at, :updated_at)
        end

      end
    end
  end
end
