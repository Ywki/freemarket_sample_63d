class UsersController < ApplicationController
  before_action :set_user, only: [:saling, :selling, :sold]

  def new
  end

  def create
    @user = User.new(
      nickname: session[:nickname], # sessionに保存された値をインスタンスに渡す
      email: session[:email],
      password: session[:password],
      # password_confirmation: session[:password_confirmation],
      last_name: session[:last_name], 
      first_name: session[:first_name], 
      last_name_kana: session[:last_name_kana], 
      first_name_kana: session[:first_name_kana], 
      birthday_year: session[:birthday_year],
      birthday_month: session[:birthday_month],
      birthday_day: session[:birthday_day],
    )
    if @user.save
      # ログインするための情報を保管
      session[:id] = @user.id
      redirect_to complete_users_path
    else
      render '/signup/registration'
    end
  end

  def login
  end

  def show
  end

  def edit
  end

  def zoom
  end
  
  def registration
  end

  def profile
  end

  def card_info
  end

  def logout
  end

  def identification
    @birthday1 = current_user.birthday_year.name
    @birthday2 = current_user.birthday_month.name
    @birthday3 = current_user.birthday_day.name
  end

  def saling
    @items = current_user.saling_items
  end

  def selling
    @items = current_user.selling_items
  end

  def sold
    @items = current_user.sold_items
  end

  def selling_items
    @items = Item.where(saler_id: current_user.id)
  end

  private

  def set_user
    user = User.find(params[:id])
  end


end
