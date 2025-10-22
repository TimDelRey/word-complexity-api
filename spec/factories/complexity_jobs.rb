# == Schema Information
#
# Table name: complexity_jobs
#
#  id         :bigint           not null, primary key
#  error      :string
#  result     :jsonb
#  status     :integer          not null
#  text       :string
#  words      :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :complexity_job do
    status { 1 }
    words { "" }
    result { "" }
    error { "MyString" }
    text { "MyString" }
  end
end
