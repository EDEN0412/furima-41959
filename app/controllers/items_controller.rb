class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end


  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :image, :category_id, :condition_id, :delivery_fee_id,
                                 :prefecture_id, :shipping_days_id).merge(user_id: current_user.id)
  end

  def correct_user
    @item = Item.find(params[:id])
    return if current_user.id == @item.user.id
    redirect_to root_path
  end
end
