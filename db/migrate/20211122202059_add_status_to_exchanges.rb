class AddStatusToExchanges < ActiveRecord::Migration[5.2]
  def change
    add_column :exchanges, :status, :integer
  end
end
