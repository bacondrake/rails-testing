class Zombie < ApplicationRecord
  validates :name, :graveyard, presence: true
  has_many :tweets
  has_one :weapon

  def avatar_url
    "http://zombitar.com/#{id}.jpg"
  end

  def decapitate
    weapon.slice(self)
    self.status = "dead again"
  end

  # Obviously Zoogle is not used, refer to the test for an example of testing an external service
  def geolocate
    loc = Zoogle.graveyard_locator(self.graveyard)
    "#{loc[:latitude]}, #{loc[:longitude]}"
  end
end

# This is a fake class to make the geolocate method work, therefore the test will work too
class Zoogle < ApplicationRecord
  def graveyard_locator(zombie)
    # Fake return data, will always call the same thing no matter what zombie is passed through
    zombie = {
      latitude: 2,
      longitude: 3
    }
  end
end