class CardsController < ApplicationController
  require 'payjp'
  before_action :set_card

  # 後ほど登録したクレジットの表示画面を作成します。
  def index
  end

  # クレジットカード情報入力画面
  def new
    
  end

  # 登録画面で入力した情報をDBに保存
  def create
    
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    if params['payjp-token'].blank?
      render 'cards/index'
    else
      customer = Payjp::Customer.create( # ここで先ほど生成したトークンを顧客情報と紐付け、PAY.JP管理サイトに送信
        email: current_user.email,
        card: params['payjp-token'],
        metadata: {user_id: current_user.id} # 記述しなくても大丈夫です
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to cards_path
      else
        redirect_to route_patu
      end
    end
  end

  # 後ほど削除機能を実装します。
  def destroy
  end

  def show
    @card
    if card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @customer_card = customer.cards.retrieve(card.card_id)
    end
  end
  def buy
    
    @item = Item.find(2)
    @price = "¥ #{@item.price.to_s(:delimited)}"
  end

  def confimation
    if @card.blank?
      redirect_to action: "new"
      flash[:alert] = '購入にはクレジットカード登録が必要です'
    else
      @item = Item.find(3) #.find(params[id])後にしようします。
     # 購入した際の情報を元に引っ張ってくる
      card = Card.find(1) #.find(params[id])後にしようします。
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

  def completed
  end

  private

  def set_card
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end
end
