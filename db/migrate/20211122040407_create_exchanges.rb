class CreateExchanges < ActiveRecord::Migration[5.2]
  def change
    create_table :exchanges do |t|
      t.references :user1, foreign_key: { to_table: :users }
      t.references :user2, foreign_key: { to_table: :users }
      t.references :book1, foreign_key: { to_table: :books }
      t.references :book2, foreign_key: { to_table: :books }

      t.timestamps
    end
  end
end
