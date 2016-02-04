require "rubillow"

class ZillowController < ApplicationController

  def zillow
    # eventually, values for :address and :citystatezip will have to be replaced
    # with variables, passed in via AJAX from Google Maps address data, gathered
    # during search
    @property = Rubillow::PropertyDetails.deep_search_results({ :address => '601 1st St NW', :citystatezip => 'moultrie,ga,31768' })
    @propertyz = @property.zpid
    @property_comps = Rubillow::PropertyDetails.deep_comps({ :zpid => @propertyz , :count => 5 })
    @property_updated = Rubillow::PropertyDetails.updated_property_details({zpid: @propertyz})
    #number_of_floors => @property_updated.number_of_floors?
    # :property => @property,
    # :comps    => @property_comps,
    # :updated  => @property_updated,

    zillow_score = ZillowScore.new(
      :finished_square_feet => @property.finished_square_feet,
      :lot_size_square_feet => @property.lot_size_square_feet,
      :zillow_urls => @property.links,
      :property_zpid => @propertyz,
      :property_address => @property.full_address
    )

      @zillow_lot = zillow_score.lot_size
      @zillow_interior = zillow_score.interior_square_feet
      @zillow_score = zillow_score.total_score
      @zillow_address = zillow_score.address
      @zurls = zillow_score.zurls
      @zpid = zillow_score.zpid


     render json: {
                    :zillow_lot => @zillow_lot,
                    :zillow_interior => @zillow_interior,
                    :zillow_score => @zillow_score,
                    :zillow_address => @zillow_address,
                    :zurls => @zurls,
                    :zpid => @zpid

     }

  end

end
