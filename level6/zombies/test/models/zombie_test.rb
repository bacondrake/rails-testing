require 'test_helper'

class ZombieTest < ActiveSupport::TestCase
  # should methods made available by shoulda gem. The gem documentation has a list of the methods
  should validate_presence_of(:name)
  should validate_presence_of(:graveyard)
  should have_many(:tweets)
  # should ensure_length_of(:tweets).is_at_least(2).is_at_most(140) # Not used, here as an example of validation method chaining

  def setup
    # Use FactoryGirl to create several zombies. Sequencing in the factories/zombies.rb file means we don't get a validation error on the requirement to keep the name unique
    5.times { Factory(:zombie) }

    @z = zombies(:ash) # Keep the fixture until all test are changed to factories
    # @zombie_1 = Factory(:zombie) # This is the same as @z = FactoryGirl.create(:zombie)
    # @zombie_2 = Factory(:zombie, name: "Ash1") # Create a second zombie but rewrite the name attribute to something unique, as required in our model
  end

  test "invalid with all attributes" do
    assert @z.valid?, "Zombie was not valid"
  end

  test "invalid name gives error message" do
    @z.name = nil
    assert_presence(@z, :name)
  end

  test "invalid graveyard gives error message" do
    @z.graveyard = nil
    assert_presence(@z, :graveyard)
  end

  test "can generate avatar_url" do
    assert_equal "http://zombitar.com/#{@z.id}.jpg", @z.avatar_url
  end

  # test model relationships
  test "should respond to tweets" do
    assert_respond_to @z, :tweets
  end

  test "should contain tweets" do
    assert_equal [tweets(:ash_2), tweets(:ash_1)], zombies(:ash).tweets
  end

  test "should contain only tweets that belong to zombie" do
    assert @z.tweets.all? { |t| t.zombie == @z }
  end

  # don't forget to actually create the weapon
  test "decapitate should set status to dead again" do
    @z.weapon.stubs(:slice) # #stubs replaces the code in weapon.slice to simply return nil for this test - because we are not testing any complicated code within the #slice method, just that it returns "dead again" as the zombie status
    @z.decapitate
    assert "dead again", @z.status

    # FactoryGirl version
    zombie = FactoryGirl.build(:zombie, status: "dead")
    zombie.decapitate
    assert_equal "dead again", zombie.status
  end

  test "decapitate should call slice" do
    @z.weapon.expects(:slice) # Assures the slice method is called in this test
    @z.decapitate             # #decapitate by design calls #slice, and now the test expects it to be
  end

  test "geolocate calls the Zoogle graveyard locator" do
    Zoogle.expects(:graveyard_locator).with(@z.graveyard) # Expects Zoogle's graveyard_locator method to search for @z.graveyard when the geolocate method is called
      .returns({latitude: 2, longitude: 3})
    @z.geolocate
  end

  test "geolocate returns the properly formatted lat and long" do
    Zoogle.stubs(:graveyard_locator).with(@z.graveyard) # Stub out the graveyard_locator with the zombie's graveyard so you don't get a varying lat and long response
      .returns({latitude: 2, longitude: 3})             # have it return a lat and long of 2 and 3 to be consistent
    assert_equal "2, 3", @z.geolocate                   # then we can ensure the formatting of the geolocate method is correct
  end
end
