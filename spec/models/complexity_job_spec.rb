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
require 'rails_helper'

RSpec.describe ComplexityJob, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
