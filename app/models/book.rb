class Book < ApplicationRecord
  belongs_to :user
  enum state: { Available: 0, Traded: 1 }
  has_many :exchanges, dependent: :destroy

end
