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
class ComplexityJob < ApplicationRecord
  enum :status, { pending: 0, in_progress: 1, done: 2, failed: 3 }, default: :pending

  validates :status, presence: true
  validates :words, presence: true

  before_validation :normalize_words

  def normalize_words
    self.words = Array(words).map { |w| w.to_s.strip } if words.present?
  end

  def done!(data)
    update!(status: :done, result: data)
  end

  def fail!(error)
    message = error.is_a?(Exception) ? error.message : error.to_s
    update!(
      status: :failed,
      error: [self.error, message].compact.join("\n")
    )
  end
end
