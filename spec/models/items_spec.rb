require 'rails_helper'
describe Item do
  describe '#create' do
    it "nameが空だとバリデーション" do
     item = build(:item, name: nil)
     item.valid?
     expect(item.errors[:name]).to include("を入力してください")
    end

    it "priceが空だとバリデーション" do
      item = build(:item,price: nil)
      item.valid?
      expect(item.errors[:price]).to include("を入力してください")
    end

    it "delivery_idが空だとバリデーション" do
      item = build(:item,delivery_id: nil)
      item.valid?
      expect(item.errors[:delivery_id]).to include("を入力してください")
    end

    it "textが空だとバリデーション" do
      item = build(:item, text: nil)
      item.valid?
      expect(item.errors[:text]).to include("を入力してください")
    end

    it "prefecture_idが空だとバリデーション" do
      item = build(:item, prefecture_id: nil)
      item.valid?
      expect(item.errors[:prefecture_id]).to include("を入力してください")
    end

    it "estimated_shipping_date_idが空だとバリデーション" do
      item = build(:item, estimated_shipping_date_id: nil)
      item.valid?
      expect(item.errors[:estimated_shipping_date_id]).to include("を入力してください")
    end

    it "state_idが空だとバリデーション" do
      item = build(:item, state_id: nil)
      item.valid?
      expect(item.errors[:state_id]).to include("を入力してください")
    end

    
  end
end