class CurrentLocation < ActiveRecord::Base
  belongs_to :user
  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude

  after_validation :geocode, if: :address_changed?
  after_validation :reverse_geocode, if: :address_changed?
end
