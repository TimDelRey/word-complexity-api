class Scoring
  include Service

  def initialize(result_http_struct)
    @result = result_http_struct
    @definitions = 0.0
    @synonyms = 0.0
    @antonyms = 0.0
  end

  def call
    return 0 unless @result.success? && @result.data.any?

    @result.data.each do |word|
      d, s, a = calculate_score(word)
      @definitions += d
      @synonyms += s
      @antonyms += a
    end
    score = @definitions != 0 ? (@synonyms + @antonyms) / @definitions : 0
    score.round(1)
    # return @definitions, @synonyms, @antonyms
  end

  private

  def calculate_score(data)
    d_score, s_score, a_score = 0.0, 0.0, 0.0

    data["meanings"].each do |meaning|
      definitions = meaning["definitions"] || []

      definitions.each do |definition|
        definitions_synonyms = definition["synonyms"] || []
        definitions_antonyms = definition["antonyms"] || []
        s_score += definitions_synonyms.size
        a_score += definitions_antonyms.size
      end
      d_score += definitions.size

      meaning_synonyms = meaning["synonyms"] || []
      meaning_antonyms = meaning["antonyms"] || []
      s_score += meaning_synonyms.size
      a_score += meaning_antonyms.size
    end

    return d_score, s_score, a_score
  end
end
