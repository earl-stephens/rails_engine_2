module Api
  module V1
    class CustomersController < ApplicationController

      def index
        render json: CustomerSerializer.new(Customer.all)
      end

      def show
        render json: CustomerSerializer.new(Customer.find(params[:id]))
      end

    end
  end
end
