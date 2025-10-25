# == Schema Information
#
# Table name: complexity_jobs
#
#  id         :bigint           not null, primary key
#  error      :text
#  result     :jsonb
#  status     :integer          not null
#  words      :jsonb            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :complexity_job do
    status { 0 }
    words { ["happy", "joyful", "sad", "angry"] }
    result { "" }
    error { "" }
  end
end
