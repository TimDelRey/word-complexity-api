class ComplexityWorker
  include Sidekiq::Worker
  sidekiq_options queue: :complexity_words, retry: 3

  def perform(job_id)
    job = ComplexityJob.find(job_id)
    job.update(status: :in_progress)
    result = {}

    job.words.each do |word|
      begin
        data = DictionaryApiClient.call(word)
        score = Scoring.call(data)
        result[word] = score
      rescue => e
        job.fail!(e)
        Rails.logger.error("ComplexityWorker failed for word #{word} in job #{job_id}: #{e.message}")
      end
    end

    job.done!(result)
  end
end
