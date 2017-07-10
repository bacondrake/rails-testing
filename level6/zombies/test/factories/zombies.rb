FactoryGirl.define do
  # factory :zombie do # Set the generic zombie
  #   name "Ash"
  #   graveyard "Oak Park"

  #   factory :zombie_bill do # Inherits from the :zombie factory, since graveyard is not specified it inherits from the parent and (in this case) becomes Oak Park
  #     name "Bill"
  #   end

  #   factory :zombie_mike do # Still inherits, but in this case we're overwriting both values. Helpful to have in case we have to add extra generic attributes later.
  #     name "Mike"
  #     graveyard "Sunnyvale"
  #   end
  # end

  # Create a zombie with a weapon. Since ArmedZombie is not a class, we specify the Zombie class to be used.
  # Probably a better idea to put them as a child as of the zombie class (as seen below)
  # factory :armed_zombie, class: Zombie do
  #   sequence(:name) { |i| "ArmedAsh#{i}"}
  #   association :weapon
  #   graveyard "Oak Park"
  # end

  # Set up zombie with a sequence of unique names if necessary
  factory :zombie do
    sequence(:name) { |i| "Ash#{i}" }
    graveyard "Oak Park"

    # Create zombies with weapons, inherits all the other elements
    factory :armed_zombie do
      association :weapon, factory: :hatchet # Override the generic weapon with a specific factory
    end
  end
end

=begin
Some FactoryGirl examples:

FactoryGirl.create(:zombie)         # Returns a new, saved zombie
FactoryGirl.build(:zombie)          # Returns a new, unsaved zombie
FactoryGirl.attributes_for(:zombie) # Returns a hash of attributes (name, graveyard, etc)


=end