class YelpScore
  # Expected format:
  # :vets     => @vets.businesses,
  # :services => @pet_services.businesses,
  # :stores   => @pet_stores.businesses,
  # :parks    => @parks.businesses,

  attr_accessor :score_hash

  def initialize(score_hash)
    @score_hash = score_hash
  end

  def overall_yelp_score
     total_pet_services_score + parks_score + vet_score
     #MVP: calculate overall score from all APIs by doing math on map view using JS
     #2.0: calculate overall score from all APIs  in a separate controller
  end

  def total_score(score_key)
    # expecting 10 businesses
    if score_key == nil
      0
    else
      businesses(score_key).map {|b| b.rating}.sum
    end
  end

  def biz_distance(score_key)
    businesses(score_key).map {|b| (b.distance)/1760}
    # converted distance from yards to miles for all businesses
  end

  def biz_name(score_key)
    businesses(score_key).map {|b| b.name}
  end

  def park_names
    biz_name(:parks)
  end

  def park_distance
    biz_distance(:parks).first
    # (first park in the list can list distance of all parks by)
    # biz_distance(:parks)
  end

  def parks_score
    return 0 if park_distance == nil
    #  (total_score(:parks)/10)
    if park_distance < 0.26
      park_score = 20
    elsif park_distance < 1
      park_score = 15
    elsif park_distance < 2
      park_score = 10
    elsif park_distance < 5
      park_score = 5
    else
      park_score = 0
    end
  end

  def vet_names
    biz_name(:vets)
  end

  def vet_score
  # vet score will be out of 20 total points
  # edit based off distance
    if (total_score(:vets) == 0)
      vet_score = 0
    elsif (total_score(:vets)/10) > 4.9
      vet_score = 20
    elsif (total_score(:vets)/10) < 4.9 && (total_score(:vets)/10) >= 4.0
      vet_score = 16
    elsif (total_score(:vets)/10) < 4.0 && (total_score(:vets)/10) >= 3.0
      vet_score = 12
    elsif (total_score(:vets)/10) < 3.0 && (total_score(:vets)/10) >= 2.0
      vet_score = 8
    else
      vet_score = 4
    end
  end

  def services_names
    biz_name(:services)
  end

  def services_score
    if (total_score(:services) == 0)
      services_score = 0
    elsif (total_score(:services)/10) > 4.9
      services_score = 10
    elsif (total_score(:services)/10) < 4.9 && (total_score(:services)/10) >= 4.0
      services_score = 8
    elsif (total_score(:services)/10) < 4.0 && (total_score(:services)/10) >= 3.0
      services_score = 6
    elsif (total_score(:services)/10) > 3.0 && (total_score(:services)/10) >= 2.0
      services_score = 4
    else
      services_score = 2
    end
  end

  def stores_names
    biz_name(:stores)
  end

  def stores_score
    if total_score(:stores) == 0
      stores_score = 0
    elsif total_score(:stores)/10 > 4.9
      stores_score = 10
    elsif total_score(:stores)/10 < 4.9 && (total_score(:stores)/10) >= 4.0
      stores_score = 8
    elsif total_score(:stores)/10 < 4.0 && (total_score(:stores)/10) >= 3.0
       stores_score = 6
    elsif total_score(:stores)/10 < 3.0 && (total_score(:stores)/10) >= 2.0
      stores_score = 4
    else
      stores_score = 2
    end
  end

  def total_pet_services_score
    # stores score + the services score will be out of 20 total points
    services_score + stores_score
  end

  def businesses(score_key)
    @score_hash[score_key]
  end
end
