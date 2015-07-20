class CurrentLocation < ActiveRecord::Base
  belongs_to :user
  geocoded_by :address

  after_validation :geocode, if: :address_changed?

  # def set_location
  #   self.location = Geocoder.search(self.address).first.coordinates if self.address_changed? || self.new_record?
  # end
end
