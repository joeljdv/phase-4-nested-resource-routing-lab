class ItemsController < ApplicationController

  def index
    
    if params[:user_id]
      use = User.find_by(id: params[:user_id])
      user_items = use.items
      render json: user_items, include: :user
    else
      user_items = Item.all 
      render json: user_items, include: :user
    end  
  end

  def show
  item = Item.find_by(id: params[:id])
    if item
      render json: item, include: :user
    else
      render json: {error: "No such Item"}, status: :not_found
    end
  end

  def create
    user = User.find_by(id: params[:user_id])
    if user
      item = user.items.create(params.permit(:name, :description, :price))
      render json: item, status: :created
    else
      render json: {error: "User not found"}, status: :not_found
    end
  end

end
