class YelpScore
  # Expected format:
  # :vets     => @vets.businesses,
  # :services => @pet_services.businesses,
  # :stores   => @pet_stores.businesses,
  # :parks    => @parks.businesses,

  def initialize(score_hash)
    @score_hash = score_hash
  end

  def overall_score
    total_score(:vets)*0.25 +total_score(:services)*0.25 + total_score(:stores)*0.25 + total_score(:parks)*0.25
    
  end

  def total_score(score_key)
    # expecting 10 businesses: 5 * 10 = 50???
    businesses(score_key).map {|b| b.rating}.sum
    # .reduce (:+) adds up all the scores together in ruby!
  end
  #
  def businesses(score_key)
    @score_hash[score_key]
  end
end
