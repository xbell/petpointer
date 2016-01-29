require 'yelp'

class YelpController < ApplicationController

  def yelp
    # default view for loading /yelp view
    # don't think we need this once searches come straight from homepage and/or map page
    @response = Yelp.client.search("1410 NE Campus Parkway, Seattle WA 98195", { term: "veterinary", limit: 20, sort: 1, radius_filter: 8046.72})
  end

  def search
    @address      = params[:address]
    @vets         = Yelp.client.search(@address, {category_filter: 'vet', limit: 10, sort: 1, radius_filter: 8046.72})
    @pet_services = Yelp.client.search(@address, {category_filter: 'dogwalkers,pet_sitting,groomer,pet_training', limit: 10, sort: 1, radius_filter: 8046.72})
    @pet_stores   = Yelp.client.search(@address, {category_filter: 'petstore', limit: 10, sort: 1, radius_filter: 8046.72})
    @parks        = Yelp.client.search(@address, {category_filter: 'parks,dog_parks,beaches', limit: 10, sort: 1, radius_filter: 8046.72})
    @response     = @vets.businesses + @pet_services.businesses + @pet_stores.businesses + @parks.businesses
    render json: @response.to_json
  end

end
