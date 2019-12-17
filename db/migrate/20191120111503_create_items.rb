class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string  :name
      t.integer :size
      t.integer :state_id
      t.integer :delivery_id
      t.integer :shipping_method_id
      t.integer :estimated_shipping_date_id
      t.integer :category_id
      t.integer :price
      t.text    :text
      t.integer :inappropriate_item
      t.integer :prefecture_id
      t.references :saler, foreing_key: true, default: ""
      t.references :buyer, foreing_key: true, default: ""
      t.references :user, foreing_key: true, default: ""
      t.timestamps
    end
  end
end