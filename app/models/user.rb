class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :books
         has_many :exchanges, dependent: :destroy
         has_many :booklists
         has_many :listed_books, :through => :booklists, :source => :book
         validates :email, :phone_number, uniqueness: true
end
