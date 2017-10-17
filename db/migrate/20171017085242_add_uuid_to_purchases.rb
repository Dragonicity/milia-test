class AddUuidToPurchases < ActiveRecord::Migration[5.1]
  def change
    add_column :purchases, :uuid, :string
  end
end
