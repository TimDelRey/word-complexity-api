module Api
  module V1
    class ComplexityJobsController < ActionController::API
      def create
        body = request.raw_post
        return render json: { error: "Body is empty" }, status: :bad_request if body.blank?
        words = JSON.parse(body)

        job = ComplexityJob.create(words: words)

        ComplexityWorker.perform_async(job.id)

        return render json: { job_id: job.id } unless job.failed?
        render json: { Error: job.error }
      end

      def show
        job = ComplexityJob.find_by(id: params[:job_id])

        return render(json: { error: "Try another ID" }, status: :not_found) unless job
        return render(json: { status: job.status, error: job.error }) if job.failed?
        render json: { status: job.status, result: job.result }
      end
    end
  end
end
