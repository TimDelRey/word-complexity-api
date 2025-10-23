module Api
  module V1
    class ComplexityJobsController < ActionController::API
      def create
        words = request.request_parameters
        job = ComplexityJob.create(words: { words })
        # джоба в сайдкике


        return json: { job_id: job.id }
      end

      def show
        job = ComplexityJob.select(:status, :result).find(params[:job_id])
        render json: job.as_json(except: :id)
      end
    end
  end
end
