class Review < ApplicationRecord
  after_validation :report_validation_errors_to_rollbar
  belongs_to :user
  belongs_to :book
end
