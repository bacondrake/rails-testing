class Weapon < ApplicationRecord
  belongs_to :zombie
  validates_presence_of :name

  def slice(*args)
    return 1 # pretends to be non nil data, the idea is that it could be complicated
  end
end
