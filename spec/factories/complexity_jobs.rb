FactoryBot.define do
  factory :complexity_job do
    status { 1 }
    words { "" }
    result { "" }
    error { "MyString" }
    text { "MyString" }
  end
end
