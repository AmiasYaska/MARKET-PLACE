class PurchasesController < ApplicationController
    before_action :authenticate_user!
  
    def create
      @product = Product.includes(:user).find(params[:product_id])
      
      if @product.user == current_user
        redirect_to products_path, alert: "You cannot purchase your own product."
        return
      end

      if current_user.purchased?(@product)
        redirect_to @product, alert: "Already purchased"
        return
      end
  
      @purchase = current_user.purchases.create(product: @product)
      
      if @purchase.persisted?
        redirect_to @product, notice: "Purchase successful!"
      else
        redirect_to @product, alert: "Purchase failed."
      end
    end
  end