require 'yelp'

class YelpController < ApplicationController

  def yelp
    # default view for loading /yelp view
    # don't think we need this once searches come straight from homepage and/or map page
    @response = Yelp.client.search("1410 NE Campus Parkway, Seattle WA 98195", { term: "veterinary", limit: 20, sort: 1, radius_filter: 8046.72})
  end

  def search
    @address  = params[:address]
    @term     = params[:term]
    @response = Yelp.client.search(@address, { term: @term, limit: 20, sort: 1, radius_filter: 8046.72})
    @response = @response.businesses.to_json
    render json: @response
  end

end
