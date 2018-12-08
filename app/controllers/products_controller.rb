class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  def index
    @products = Product.all

    render json: @products
  end

  # GET /products/1
  def show
    render json: @product
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
  end

  # POST /products/calculate
  def calculate
    dimensions = [
      (product_params[:length] rescue nil), 
      (product_params[:width] rescue nil), 
      (product_params[:height] rescue nil), 
      (product_params[:weight] rescue nil)
    ]

    if dimensions.any? {|e| !/\A\d+\z/.match(e) }
      render json: {params: ["Missing/Invalid params. (:width, :height, :length, :weight and :type allowed.)"]}, status: :unprocessable_entity
    else
      dimensions << (product_params[:type] rescue nil) if Product::TYPES.include?(product_params[:type])
      render json: (Product.calculate(*dimensions) rescue nil)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:name, :type, :length, :width, :height, :weight)
    end
end
