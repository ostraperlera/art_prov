# This migration comes from spree_marketplace (originally 20150201132712)
class AddFeaturedToSpreeProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :featured, :boolean, default: false
  end
end
