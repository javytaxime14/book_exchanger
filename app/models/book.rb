class Book < ApplicationRecord
  belongs_to :user
  enum state: { Available: 0, Traded: 1 }
  has_many :exchanges, dependent: :destroy
  has_many :booklists
  has_many :listing_users, :through => :booklists, :source => :user

  def is_listed?(user)
    self.listing_users.include?(user)
  end

  def list(user)
    Booklist.create(user: user, book: self)
  end

  def unlist(user)
    Booklist.where(user: user, book: self).destroy_all
  end
end