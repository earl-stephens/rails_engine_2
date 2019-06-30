module Api
  module V1
    module Merchants
      class RandomController < ApplicationController

        def index
          render json: MerchantSerializer.new(Merchant.random)
        end

      end
    end
  end
end
