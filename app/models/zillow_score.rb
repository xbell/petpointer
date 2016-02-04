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
    a = lot_size.to_i - interior_square_feet.to_i
    if a > 8000
      a = 20
    elsif a > 2000
      a = 15
    elsif a > 1400
      a = 10
    elsif a > 650
      a = 5
    elsif a > 150
      a = 0
    end
  end

  def lot_size
    # @score_hash[:finished_square_feet]
    @score_hash[:lot_size_square_feet]
  end

  def interior_square_feet
    @score_hash[:finished_square_feet]
  end

  def address
    @score_hash[:property_address]
  end

  def zpid
    @score_hash[:property_zpid]
  end

  def zurls
    @score_hash[:zillow_urls][:homedetails]
  end

end
