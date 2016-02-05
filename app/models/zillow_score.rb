class ZillowScore
  # Expected format:
  #:finished_square_feet => @property.finished_square_feet,
  # :lot_size_square_feet => @property.lot_size_square_feet,
  # :zillow_urls => @property.links,
  # :property_zpid => @propertyz,
  # :property_address => @property.full_address

  def initialize(score_hash)
    @score_hash = score_hash
  end

  def total_score
    a = lot_size.to_i + interior_square_feet.to_i
    if a == nil
      0
    elsif a > 43000
      a = 20
    elsif a > 8000
      a = 16
    elsif a > 2000
      a = 14
    elsif a > 1400
      a = 10
    elsif a > 650
      a = 8
    elsif a > 150
      a = 4
    end
  end

  def lot_size
    # @score_hash[:finished_square_feet], call by symbol
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
