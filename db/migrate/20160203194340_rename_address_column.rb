class RenameAddressColumn < ActiveRecord::Migration
  def change
    rename_column :favorites, :address, :zillow_id
  end
end
