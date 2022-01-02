FactoryBot.define do
  factory :search do
    user { nil }
    query { "MyString" }
    query_type { "MyString" }
    alternative { false }
    quoted { false }
    incognito { false }
  end
end
