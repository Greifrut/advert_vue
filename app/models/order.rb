class Order < ApplicationRecord
  belongs_to :user

  validates :purchaser_name, presence: true, length: { minimum: 2 }
  validates :purchaser_phone, presence: true, length: { is: 11 }
end
