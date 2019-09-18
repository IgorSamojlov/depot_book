class AddLocaleToProducts < ActiveRecord::Migration
  def change
    add_column :products, :locale, :string, null: false
  end
end
