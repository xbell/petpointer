class ZillowScore

  def initialize(score_hash)
    @score_hash = score_hash
  end

  def total_score(score_key)
    properties(score_key).finished_square_feet
  end


  def properties(score_key)
    @score_hash[score_key]
  end

end
