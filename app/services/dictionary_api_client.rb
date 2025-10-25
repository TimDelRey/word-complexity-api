class DictionaryApiClient
  include Service

  BASE_URL = 'https://api.dictionaryapi.dev/api/v2/entries/en'.freeze

  def initialize(word)
    @word = word
  end

  def call
    response = Faraday.get("#{BASE_URL}/#{@word}")

    case response.status
    when 200
      data = JSON.parse(response.body)
      success(data)
    when 404
      data = JSON.parse(response.body) rescue {}
      failure(data["message"] || "Word not found")
    else
      failure("HTTP #{response.status}")
    end
  rescue StandardError => e
    Rails.logger.error("Dictionary API error for #{@word}: #{e.message}")
    failure(e.message)
  end
end
