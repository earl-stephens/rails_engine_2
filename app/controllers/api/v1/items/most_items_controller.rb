module Api
  module V1
    module Items
      class MostItemsController < ApplicationController

        def index
          # binding.pry
          quantity = params[:quantity]
          render json: ItemSerializer.new(Item.most_items(quantity))
        end

      end
    end
  end
end
