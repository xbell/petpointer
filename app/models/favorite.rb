class Favorite < ActiveRecord::Base
  belongs_to :user

  validates :address, uniqueness: {scope: :user_id}
end
