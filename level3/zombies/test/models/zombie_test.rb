require 'test_helper'

class ZombieTest < ActiveSupport::TestCase
  # should methods made available by shoulda gem. The gem documentation has a list of the methods
  should validate_presence_of(:name)
  should validate_presence_of(:graveyard)
  should have_many(:tweets)
  # should ensure_length_of(:tweets).is_at_least(2).is_at_most(140) # Not used, here as an example of validation method chaining

  def setup
    @z = zombies(:ash)
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
end
