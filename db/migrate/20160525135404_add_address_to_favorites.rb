class AddAddressToFavorites < ActiveRecord::Migration
  def change
    add_column :favorites, :address, :string
  end
end
