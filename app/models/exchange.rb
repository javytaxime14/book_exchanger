class Exchange < ApplicationRecord
    belongs_to :user1, class_name: 'User', foreign_key: 'user1_id'
    belongs_to :user2, class_name: 'User', foreign_key: 'user2_id'
    belongs_to :book1, class_name: 'Book', foreign_key: 'book1_id'
    belongs_to :book2, class_name: 'Book', foreign_key: 'book2_id'
    enum status: [:pending, :accepted, :rejected]
    after_validation :report_validation_errors_to_rollbar
   

    
end
