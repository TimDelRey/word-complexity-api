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
require 'rails_helper'

RSpec.describe ComplexityJob, type: :model do
  let(:valid_data) { ["happy", "joyful", "sad", "angry"] }

  describe 'test creating/saving' do
    subject(:job) { build(:complexity_job, words: words) }

    context 'when valid data' do
      let(:words) { valid_data }

      it 'job are created with defaukt status and words are not empty' do
        expect(job).to be_valid
        expect(job.save).to eq(true)
        expect(job.status).to eq("pending")
      end
    end

    context 'when words are not array of strings' do
      context 'words are array of any elements' do
        let(:words) { ["", 1234, { "sad": 123 }, "    angry   "] }

        it 'words convert into valid format' do
          expect(job).to be_valid
          expect(job.save).to eq(true)
          expect(job.status).to eq("pending")
        end
      end

      context 'when words are not array' do
        let(:words) { 1234 }

        it 'words convert into valid format' do
          expect(job).to be_valid
          expect(job.save).to eq(true)
        end
      end
    end

    context 'when words are empty' do
      it 'instanse was not saved' do
        job = build(:complexity_job, words: nil)
        expect(job).not_to be_valid
        expect(job.save).to eq(false)
      end
    end
  end

  describe 'test actions' do
    subject(:job) { create(:complexity_job, words: valid_data) }

    context 'when job get done' do
      it 'job status changed to done and result is saved' do
        expect(job.status).to eq("pending")
        job.done!({ "some string": 2 })
        expect(job.status).to eq("done")
        expect(job.result).to eq({ "some string" => 2 })
      end
    end
    context 'when job get fail' do
      it 'job status changed to failed and all errors are saved' do
        expect(job.status).to eq("pending")
        job.fail!("first error")
        expect(job.status).to eq("failed")
        expect(job.error).to eq("\nfirst error")
        job.fail!("second error")
        expect(job.error).to eq("\nfirst error\nsecond error")
      end
    end
  end
end
