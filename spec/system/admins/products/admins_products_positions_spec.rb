require 'rails_helper'

RSpec.describe 'Admins::Products::Positions', type: :system do
  describe '商品の並び替え機能' do
    let(:admin) { create(:admin) }

    before do
      # playwrightだとドラッグ&ドロップができないため、seleniumを使用
      driven_by(:selenium_chrome_headless)

      sign_in admin

      product1 = create(:product, name: 'みかん')
      product2 = create(:product, name: 'りんご')
      product3 = create(:product, name: 'ぶどう')

      product1.update(row_order_position: 0)
      product2.update(row_order_position: 1)
      product3.update(row_order_position: 2)
    end

    it '商品の順番を変更できること' do
      visit admins_products_path

      product_names = all('tbody tr').map { |row| row.find('td.text-center.text-decoration-none').text.strip }
      expect(product_names).to eq %w[みかん りんご ぶどう]

      first('tbody tr').drag_to all('tbody tr').last

      visit current_path

      product_names = all('tbody tr').map { |row| row.find('td.text-center.text-decoration-none').text.strip }
      expect(product_names).to eq %w[りんご ぶどう みかん]
    end
  end
end
