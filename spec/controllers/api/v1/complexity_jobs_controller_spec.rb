require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.inline!

RSpec.describe Api::V1::ComplexityJobsController, type: :controller do
  describe 'GET /show' do
    subject(:json) do
      get :show, params: { job_id: job_id }
      JSON.parse(response.body)
    end

    let(:job_id) { job.id }

    context 'when job is not failed' do
      context 'when job has just been created' do
        let(:valid_data) { ["happy", "joyful", "sad", "angry"] }
        let!(:job) { create(:complexity_job, words: valid_data) }

        it 'renders status pengind' do
          expect(response).to have_http_status(:ok)
          expect(json["status"]).to eq("pending")
        end
      end

      context 'when response is received' do
        let(:valid_data) { ["boat", "sea"] }
        let!(:job) { create(:complexity_job, words: valid_data) }

        before { ComplexityWorker.perform_async(job.id) }

        it 'renders status done and result' do
          expect(response).to have_http_status(:ok)
          expect(json["status"]).to eq("done")
          expect(json["result"]).to eq({ "boat" => 0.4, "sea" => 0.3 })
        end
      end
    end

    context 'when job is failed' do
      let(:valid_data) { ["happy", "joyful", "sad", "angry"] }
      let!(:job) { create(:complexity_job, words: valid_data) }

      before { job.fail!("test error") }

      it 'renders error' do
        expect(response).to have_http_status(:ok)
        expect(json["status"]).to eq("failed")
        expect(json["error"]).to eq("\ntest error")
      end
    end

    context 'when wrong ID of job' do
      let(:job_id) { 1234 }

      it 'renders 404' do
        json
        expect(response).to have_http_status(:not_found)
        expect(json["error"]).to eq("Try another ID")
      end
    end
  end

  describe 'POST /create' do
    subject(:json) do
      post :create, body: words.to_json, as: :json
      JSON.parse(response.body)
    end

    context 'when valid array of strings' do
      let(:words) { ["one", "two"] }

      it 'returns id of job' do
        expect(response).to have_http_status(:ok)
        expect(json).to have_key("job_id")

        job = ComplexityJob.find(json["job_id"])
        expect(job.words).to eq(words)
        expect(job.done?).to be true
      end
    end

    context 'when array of random' do
      let(:words) { ["  ", 1234, nil, "hello"] }

      it 'work with invalid strings has been done' do
        expect(response).to have_http_status(:ok)
        expect(json).to have_key("job_id")

        job = ComplexityJob.find(json["job_id"])
        expect(job.words).to eq(["", "1234", "", "hello"])
        expect(job.done?).to be true
      end
    end
  end
end
