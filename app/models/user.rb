class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :timeoutable, :omniauthable, omniauth_providers: [:github]
         has_many :books
         has_many :exchanges, dependent: :destroy
         has_many :booklists
         has_many :listed_books, :through => :booklists, :source => :book
         validates :email, :phone_number, uniqueness: true
         has_many :friends
         has_many :reviews
         after_validation :report_validation_errors_to_rollbar
     

  def is_following?(friend_id)
    self.friends.where(:friend_id => friend_id).exists?
  end

  def arr_friends_id
    friends.pluck(:friend_id)
  end

  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = provider_data.info.name   # assuming the user model has a name
      user.last_name = provider_data.info.last_name
    end
  end
end
