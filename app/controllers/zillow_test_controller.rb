require "rubillow"

  class ZillowTestController < ApplicationController

    def zillow
      @property = Rubillow::PropertyDetails.deep_search_results({ :address => '601 1st St NW', :citystatezip => 'moultrie,ga,31768' })
      # @prop_details= Rubillow::PropertyDetails.updated_property_details({:zpid => "49076278"})
      @propertyz = @property.zpid
      @property_comps = Rubillow::PropertyDetails.deep_comps({ :zpid => @propertyz , :count => 5 })

      @property_updated = Rubillow::PropertyDetails.updated_property_details({zpid: @propertyz})

    end

  end
