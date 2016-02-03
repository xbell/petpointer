class ZillowScore
  # Expected format:
  # :vets     => @vets.businesses,
  # :services => @pet_services.businesses,
  # :stores   => @pet_stores.businesses,
  # :parks    => @parks.businesses,

  def initialize(score_hash)
    @score_hash = score_hash
  end

  def total_score
    properties
  end




  def properties
    a = @score_hash[:finished_square_feet]
    b = @score_hash[:lot_size_square_feet]
      
  end

end
