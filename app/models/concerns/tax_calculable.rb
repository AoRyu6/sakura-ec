module TaxCalculable
  extend ActiveSupport::Concern

  TAX_RATE = 0.08

  def price_with_tax
    return nil if price.blank?

    price * (1 + TAX_RATE)
  end
end
