FactoryBot.define do
  factory :order do
    owner_name { "MyString" }
    owner_phone { 89745265321 }
    ad_id {1}
    user {nil}
  end
end
