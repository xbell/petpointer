require 'yelp'

class YelpController < ApplicationController

  def yelp
    @address      = "1410 NE Campus Parkway, Seattle WA 98195"
    @vets         = Yelp.client.search(@address, {category_filter: 'vet', limit: 10, sort: 1, radius_filter: 8046.72})
    @pet_services = Yelp.client.search(@address, {category_filter: 'dogwalkers,pet_sitting,groomer,pet_training', limit: 10, sort: 1, radius_filter: 8046.72})
    @pet_stores   = Yelp.client.search(@address, {category_filter: 'petstore', limit: 10, sort: 1, radius_filter: 8046.72})
    @parks        = Yelp.client.search(@address, {category_filter: 'parks,dog_parks,beaches', limit: 10, sort: 1, radius_filter: 8046.72})
    @response     = {
        :vets     => @vets.businesses,
        :services => @pet_services.businesses,
        :stores   => @pet_stores.businesses,
        :parks    => @parks.businesses
      }




    render json: @response.to_json
  end









end
