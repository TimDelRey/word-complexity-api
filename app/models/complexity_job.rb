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
class ComplexityJob < ApplicationRecord
end
