class LineItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product, optional: true
  belongs_to :cart, optional: true

  scope :title_order, -> { order("line_items.title ASC") }

  def total_price
    quantity * price
  end
end
