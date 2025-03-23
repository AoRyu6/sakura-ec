# == Schema Information
#
# Table name: products
#
#  id             :bigint           not null, primary key
#  description    :text             default(""), not null
#  name           :string           not null
#  price_cents    :integer
#  price_currency :string           default("JPY"), not null
#  published      :boolean          default(FALSE), not null
#  row_order      :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '公開機能' do
    it '公開するには商品名,税抜き価格商品画像,商品説明が必要であること' do
      product = Product.new(
        name: 'りんご',
        price: 100,
        image: Rails.root.join('spec/fixtures/files/product.png').open,
        description: '新鮮なりんごです。',
        published: true
      )
      product.valid?

      expect(product).to be_valid
    end

    it '商品説明がなければ公開できないこと' do
      product = build(:product, :published, description: nil)
      product.valid?

      expect(product.errors.messages[:description]).to include('を入力してください')
    end

    it '価格がなければ公開できないこと' do
      product = build(:product, :published, price: nil)
      product.valid?

      expect(product.errors.messages[:price]).to include('は0以上の値にしてください')
    end

    it '商品画像がなければ公開できないこと' do
      product = build(:product, :published, image: nil)
      product.valid?

      expect(product.errors.messages[:image]).to include('を添付してください')
    end
  end
end
