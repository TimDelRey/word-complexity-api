require 'rails_helper'

RSpec.describe "Api::V1::ComplexityJobs", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/api/v1/complexity_jobs/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/api/v1/complexity_jobs/show"
      expect(response).to have_http_status(:success)
    end
  end
end
