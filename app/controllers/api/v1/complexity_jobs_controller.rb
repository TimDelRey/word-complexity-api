module Api
  module V1
    class ComplexityJobsController < ActionController::API
      def create
        words = JSON.parse(request.raw_post)
        job = ComplexityJob.create(words: words)

        ComplexityWorker.perform_async(job.id)

        render json: { job_id: job.id }
        # handle error
      end

      def show
        job = ComplexityJob.select(:status, :result).find(params[:job_id])
        render json: job.as_json(except: :id)
        # handle error
      end
    end
  end
end
