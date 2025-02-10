require 'rails_helper'

RSpec.describe PurchaseForm, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @purchase_form = FactoryBot.build(:purchase_form, user_id: @user.id, item_id: @item.id)
  end

  context '内容に問題がない場合' do
    it '全ての値が正しく入力されていれば保存できること' do
      expect(@purchase_form).to be_valid
    end

    it '建物名が空でも保存できること' do
      @purchase_form.building_name = ''
      expect(@purchase_form).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it 'tokenが空では保存できないこと' do
      @purchase_form.token = ''
      @purchase_form.valid?
      expect(@purchase_form.errors.full_messages).to include("Token can't be blank")
    end

    it '郵便番号が空では保存できないこと' do
      @purchase_form.postal_code = ''
      @purchase_form.valid?
      expect(@purchase_form.errors.full_messages).to include("Postal code can't be blank")
    end

    it '郵便番号が正しい形式でないと保存できないこと' do
      @purchase_form.postal_code = '1234567'
      @purchase_form.valid?
      expect(@purchase_form.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
    end

    it '都道府県が空では保存できないこと' do
      @purchase_form.prefecture_id = nil
      @purchase_form.valid?
      expect(@purchase_form.errors.full_messages).to include("Prefecture can't be blank")
    end

    it '市区町村が空では保存できないこと' do
      @purchase_form.city = ''
      @purchase_form.valid?
      expect(@purchase_form.errors.full_messages).to include("City can't be blank")
    end

    it '番地が空では保存できないこと' do
      @purchase_form.address = ''
      @purchase_form.valid?
      expect(@purchase_form.errors.full_messages).to include("Address can't be blank")
    end

    it '電話番号が空では保存できないこと' do
      @purchase_form.phone_number = ''
      @purchase_form.valid?
      expect(@purchase_form.errors.full_messages).to include("Phone number can't be blank")
    end

    it '電話番号が10桁未満では保存できないこと' do
      @purchase_form.phone_number = '090123456'
      @purchase_form.valid?
      expect(@purchase_form.errors.full_messages).to include('Phone number is too short')
    end

    it '電話番号が12桁以上では保存できないこと' do
      @purchase_form.phone_number = '090123456789'
      @purchase_form.valid?
      expect(@purchase_form.errors.full_messages).to include('Phone number is invalid. Input only number')
    end

    it '電話番号にハイフンが含まれていると保存できないこと' do
      @purchase_form.phone_number = '090-1234-5678'
      @purchase_form.valid?
      expect(@purchase_form.errors.full_messages).to include('Phone number is invalid. Input only number')
    end

    it 'userが紐付いていなければ購入できないこと' do
      @purchase_form.user_id = nil
      @purchase_form.valid?
      expect(@purchase_form.errors.full_messages).to include("User can't be blank")
    end

    it 'itemが紐付いていなければ購入できないこと' do
      @purchase_form.item_id = nil
      @purchase_form.valid?
      expect(@purchase_form.errors.full_messages).to include("Item can't be blank")
    end
  end
end
