Rails.application.routes.draw do
  devise_for :users, skip: :new,
  controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    delete 'destroy' => 'devise/sessions#destroy',as: :current_user_destroy
    get 'new' => 'devise/sessions#new'
    post 'create' => 'devise/sessions#create'
  end

  root to: "items#index"


  resources :sign_ups, only: [:index] do
    collection do
      get :registration  # 登録情報の一部を入力してもらう
      post :registration, to: 'signups#step1_validates'  #step1で入力したデータのバリデーションチャックをする(詳しくはコントローラーで説明) render後にリロードしてもエラーが出ないようにget'step1'とURLは同じに設定する
      get :sms_confirmation  # 残りの登録情報を入力してもらう
      post :sms_confirmation, to: 'signups#create' # 入力した情報すべてを保存 こっちもrenderするなら揃える
    end
  end

  resources :items, only: [:index, :show, :new, :create, :edit, :update] do
    collection do
      get :buy
      get :buy1
    end
    member do
      get :details
      get :address
    end
  end    
  resources :pays, only: [:new]
  resources :users, only: [:new, :create, :show, :edit, :destroy] do
    collection do
      get :login
    end
    member do
      get :identification
      get :logout
      get :selling
      get :saling
      get :sold
    end
  end
  resources :signup, only: [:create] do
    collection do
      get :registration
      get :sms_confirmation
      post :sms_confirmation
      get :address
      post :address
      get :card
      post :card
      get :complete
      post :complete
      get :logout
    end
    member do
      get :identification
      get :profile
      get :card_info
      get :zoom
      get :saling
      get :selling
      get :sold
    end
  end
end
