FactoryBot.define do
  factory :order do
    owner_name { "MyString" }
    owner_phone {1}
    ad_id {1}
    user {nil}
  end
end
