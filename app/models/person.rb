class Person < ActiveRecord::Base
  validates :first_name, presence: true, length: { minimum: 1, maximum: 50, allow_blank: true }
  validates :last_name, presence: true, length: { minimum: 1, maximum: 50, allow_blank: true }
end
