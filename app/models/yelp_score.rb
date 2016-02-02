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
    total_score(:vets) + total_pet_services_score + total_score(:parks)
  end


  def total_score(score_key)
    # expecting 10 businesses: 5 * 10 = 50???
    businesses(score_key).map {|b| b.rating}.sum
  end

  def vet_score
    total_score(:vets)/10
  end

  def parks_score
    total_score(:parks)/10
  end

  def services_score
    total_score(:services)/10
  end

  def stores_score
    total_score(:stores)/10
  end

  def total_pet_services_score
    vet_score + services_score + stores_score

  end
  #
  def businesses(score_key)
    @score_hash[score_key]
  end
end
