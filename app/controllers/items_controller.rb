class ItemsController < ApplicationController
  before_action :set_item, only: [:details, :show, :edit, :update, :destroy, :buy, :confimation]
  before_action :set_details, only: [:details, :show, :buy]
  before_action :set_card, only: [:confimation]
  
  def index
    @items = Item.all.limit(10).order(id: "DESC")
  end
  
  def new
    @item = Item.new
    @item.thumbnails.build
  end

  def create
    @item = Item.new(item_params)
    respond_to do |format|
      if @item.save
          params[:thumbnails][:images].each do |image|
            @item.thumbnails.create(images: image, item_id: @item.id)
          end
        format.html{redirect_to root_path}
      else
        @item.thumbnails.build
        format.html{render action: 'new'}
      end
    end
  end

  def edit
  end

  def update
    item = Item.first
    # item.thumbnails.images = MiniMagick::Image.read(open(URI.encode(item.thumbnails.images), &:read))
    # item.save!
    if @item.update!(item_params) 
      redirect_to root_path
    else
      redirect_to edit_item_path
    end
  end

  def details
    
  end
  
  def address
  end

  def buy
    @price = "¥#{@item.price.to_s(:delimited)}"
  end

  def confimation
    if @card.blank?
      redirect_to controller: "cards", action: "new"
      flash[:alert] = '購入にはクレジットカード登録が必要です'
    else
    
     # 購入した際の情報を元に引っ張ってくる
     card = current_user.card
      
      #.find(params[id])後にしようします。
     # テーブル紐付けてるのでログインユーザーのクレジットカードを引っ張ってくる
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
     # キーをセットする(環境変数においても良い)
      Payjp::Charge.create(
      amount: @item.price, #支払金額
      customer: card.customer_id, #顧客ID
      currency: 'jpy', #日本円
      )
     # ↑商品の金額をamountへ、cardの顧客idをcustomerへ、currencyをjpyへ入れる
      if @item.update(buyer_id: current_user.id)
        
        flash[:notice] = '購入しました。'
        # render template: "cards/completed" 
        redirect_to controller: "cards", action: 'completed'
      else
        flash[:alert] = '購入に失敗しました。'
        # redirect_to controller: "items", action: 'show'
      end
     #↑この辺はこちら側のテーブル設計どうりに色々しています
    end
  end

  def buy1
  end

  def show
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

private


  def item_params
    params.require(:item).permit(:name, :size, :state_id, :delivery_id, :estimated_shipping_date_id, :price, :text, :prefecture_id,  thumbnails_attributes: [:images, :id, :_destroy]).merge(user_id: current_user.id, saler_id: current_user.id)
  end
  
  def set_item
    @item = Item.find(params[:id])
  end
  
  def set_details
    @items = Item.where(saler_id: @item.saler_id).limit(6).order('id DESC')
    @price = "¥#{@item.price.to_s(:delimited)}"
    @state = @item.state.name
    @delivery = @item.delivery.name
    @date = @item.estimated_shipping_date.name
  end

  def set_card
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end

end
