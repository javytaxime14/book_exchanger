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
         has_many :friends
         has_many :reviews
  

  def is_following?(friend_id)
    self.friends.where(:friend_id => friend_id).exists?
  end

  def arr_friends_id
    friends.pluck(:friend_id)
  end
         
end
