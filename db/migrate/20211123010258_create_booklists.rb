class CreateBooklists < ActiveRecord::Migration[5.2]
  def change
    create_table :booklists do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
