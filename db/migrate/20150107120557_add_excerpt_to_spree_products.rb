class AddExcerptToSpreeProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :excerpt, :text
  end
end
