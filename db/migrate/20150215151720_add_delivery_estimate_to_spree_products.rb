class AddDeliveryEstimateToSpreeProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :delivery_estimate, :integer
  end
end
