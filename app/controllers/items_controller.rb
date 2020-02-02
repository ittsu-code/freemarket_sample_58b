class ItemsController < ApplicationController
  def index
    @item = Item.limit(10).order('id DESC')
  end

  def new
    @item = Item.new
    @category_parent_array = ["--"]
    #データベースから、親カテゴリーのみ抽出し、配列化
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
    @item.images.build
  end

  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def get_category_grandchildren
  #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def get_size
    @sizes = Size.all
  end

  def create
    @item = Item.create(item_params)
    # if @item.save!
    # end
    redirect_to root_path
  end
  def show
  
  end


  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :shipping_charge_id, :estimated_shipping_date_id, :price, :size_id,images_attributes: [:image]).merge(user_id: 1, brand_id: 1, status_id: 1, delivery_area_id: 1, shipping_method_id: 1)
  end

end
