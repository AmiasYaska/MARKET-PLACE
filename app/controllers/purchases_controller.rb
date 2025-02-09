class PurchasesController < Applicationcontroller
    before_action :authenticate_user!

    def create
        @product = Product.find(params[:product_id])

        if @product.user = current_user
            redirect_to products_path, alert: "You created this product"
            return
        end

        @purchase = current_user.purchases.create(product: @product)
        if @purchase.persisted?
            redirect_to products_path, notice: "Purchase successful"
        else
            redirect_to products_path, alert: "Purchase failed. Try again" 
        end
    end
end