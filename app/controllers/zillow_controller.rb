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
    )

    

    render json: zillow_score
  end
end
