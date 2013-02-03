require 'chingu'
require 'game_traits'

class Flare < Chingu::GameObject
  traits :bounding_circle, :collision_detection
  traits :velocity, :screen_warp, :vector
  traits :timer

	attr_accessor :angle
	
  def initialize(options={})
    super options.merge(:image => Gosu::Image["flare.png"])
    @angle = rand * 359
    after(100) { self.destroy }  
    self.zorder = 1
  end
end



