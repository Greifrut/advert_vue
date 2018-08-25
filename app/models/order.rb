class Order < ApplicationRecord
  belongs_to :user

  validates :owner_name, presence: true, length: { minimum: 2 }
  validates :owner_phone, presence: true, length: { is: 11 }
end
