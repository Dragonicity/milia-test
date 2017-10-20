class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  scope :title_order, -> { order("line_items.title ASC") }

  def total_price
    quantity * price
  end
end
