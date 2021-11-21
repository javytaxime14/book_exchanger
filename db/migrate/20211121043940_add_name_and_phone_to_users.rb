class AddNameAndPhoneToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :last_name, :string, null: false
    add_column :users, :phone_number, :integer
  end
end
