require 'yelp'
require 'json'

class YelpController < ApplicationController

  def yelp
    @address      = "1410 NE Campus Parkway, Seattle WA 98195"
    @vets         = Yelp.client.search(@address, {category_filter: 'vet', limit: 10, sort: 1, radius_filter: 8046.72})
    @pet_services = Yelp.client.search(@address, {category_filter: 'dogwalkers,pet_sitting,groomer,pet_training', limit: 10, sort: 1, radius_filter: 8046.72})
    @pet_stores   = Yelp.client.search(@address, {category_filter: 'petstore', limit: 10, sort: 1, radius_filter: 8046.72})
    @parks        = Yelp.client.search(@address, {category_filter: 'parks,dog_parks,beaches', limit: 10, sort: 1, radius_filter: 8046.72})
      # take total yelp score of all vets and create a pet score based off the yelp score
      # so for example a score of 4.5 would be a pet score of 25 out of overall score of 100
    yelp_score = YelpScore.new(
      :vets     => @vets.businesses,
      :services => @pet_services.businesses,
      :stores   => @pet_stores.businesses,
      :parks    => @parks.businesses,
    )

    @total_score = yelp_score.overall_score
    @vets_score = yelp_score.vet_score
    @parks_score = yelp_score.parks_score
    @pet_stores_score = yelp_score.stores_score
    @pet_services_score = yelp_score.services_score
    @total_pet_services_score = yelp_score.total_pet_services_score
    @park_distance = yelp_score.park_distance
    @park_names = yelp_score.park_names
    @vet_names = yelp_score.vet_names
    @pet_services_names = yelp_score.services_names
    @pet_stores_names = yelp_score.stores_names


    render json: { :total_score => @total_score,
                   :vets_score => @vets_score,
                   :vet_names => @vet_names,
                   :parks_score => @parks_score,
                   :park_distance => @park_distance,
                   :park_names => @park_names,
                   :total_pet_services_score => @total_pet_services_score,
                   :pet_stores => @pet_stores_score,
                   :pet_stores_names => @pet_stores_names,
                   :pet_services => @pet_services_score,
                   :pet_services_names => @pet_services_names
     }

  end
end
