class Zombie < ApplicationRecord
  validates :name, :graveyard, presence: true
  has_many :tweets

  def avatar_url
    "http://zombitar.com/#{id}.jpg"
  end
end
