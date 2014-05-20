class Person < ActiveRecord::Base
  validates :first_name, presence: true, length: { maximum: 50, allow_blank: true }
  validates :last_name, presence: true, length: { maximum: 50, allow_blank: true }
  validates :last_name, uniqueness: { scope: :first_name, message: 'and first name have already been taken' }
end
