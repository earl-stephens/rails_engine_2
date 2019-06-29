module Api
  module V1
    module Items
      class MostRevenueController < ApplicationController

        def index
          # binding.pry
          quantity = params[:quantity]
          render json: ItemSerializer.new(Item.most_revenue(quantity))
        end

      end
    end
  end
end
