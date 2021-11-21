class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.text :description
      t.string :genre
      t.string :publisher
      t.integer :year
      t.string :isbn, null: false
      t.integer :state, default: 0
      t.references :user, foreign_key: true
      
      t.timestamps
    end
  end
end
