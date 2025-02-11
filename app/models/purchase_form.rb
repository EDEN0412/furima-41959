class PurchaseForm
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :total_price,
                :token

  with_options presence: true do
    validates :token, presence: { message: "can't be blank" }
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Input only number' },
                             length: { minimum: 10, message: 'is too short' }
    validates :total_price, numericality: { greater_than: 0 }
  end

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      purchase = Purchase.create(user_id: user_id, item_id: item_id)
      ShippingAddress.create(
        postal_code: postal_code,
        prefecture_id: prefecture_id,
        city: city,
        address: address,
        building_name: building_name,
        phone_number: phone_number,
        purchase_id: purchase.id
      )
    end
  end
end
