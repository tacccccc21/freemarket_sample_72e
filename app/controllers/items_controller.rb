class ItemsController < ApplicationController
  before_action :set_item, only:[:create, :show, :edit, :destroy]

  def index
  end
  
  def new
    @item = Item.new
    @item.images.new
    @category_parent_array = ["---"]
      Category.where(ancestry: nil).each do |parent|
        @category_parent_array << parent.name
    end
  end

  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def create

    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end
  
  

  
  def show
    
    @user = User.find(@item.user_id)
    @address = Address.find(@item.user_id)
  end
  
  def comfilm
  end

  def destroy
    
    if @item.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  def edit
    
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end




  
  private

  def item_params
    params.require(:item).permit(:name, :text, :price, 
      :category_id, :status, :delivery_fee, :shipping_day, 
      :from_area, images_attributes: [:img]).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end

