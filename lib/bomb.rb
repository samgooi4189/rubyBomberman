require 'chingu'
require 'game_traits'
require 'flare'

class Bomb < Chingu::GameObject
  traits :bounding_circle
  traits :velocity, :screen_warp, :vector
  traits :timer
  
  attr_accessor:x,:y

  def initialize(options={})
    super options.merge(:image => Gosu::Image["bomb.png"])
    after(3000) { 	Flare.create rand * 359 => :angle , :scale => 1.0, :x => x, :y => y, :velocity => flare_velocity(10);
    self.destroy }
    self.zorder = 1
  end
  
  def flare_velocity(ratio = 1.0)
    # TODO move into vector trait
    flare_x, flare_y = vector(3*ratio) # wants to leave muzzle at velocity of 3

    return (flare_x), (flare_y)
  end
end