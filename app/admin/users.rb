ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :last_name, :phone_number, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at
  
  index do
    selectable_column
    column :name
    column :last_name
    column :phone_number
    column :email
    column :sign_in_count
    column :created_at
    column :book_count do |user|
      columns user.books.count
    end
    column :friends_count do |user|
      columns user.friends.count
    end
    column :listed_books_count do |user|
      columns user.listed_books.count
    end
    actions
  end
  
end
