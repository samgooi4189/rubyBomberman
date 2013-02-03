require 'chingu'

class Box < Chingu::GameObject
  traits :bounding_circle, :collision_detection
  traits :velocity, :screen_warp, :vector
  # score trait (give and receive)

  attr_accessor :score

  def initialize(options={})
    super({:x => rand($window.width), :y => rand($window.width), :angle => 0, :image => Gosu::Image["metroid_block.png"]}.merge(options))
    self.velocity = 0
    self.zorder = 3
    self.score = 100
  end
  def update
    super
  end

  def destroy
    super
    Gosu::Sound["explode.wav"].play
  end
end

class BoxTiny < Box
  def initialize(options={})
    super({:image => Gosu::Image["metroid_block.png"]}.merge(options))
    self.score = 10
  end
end
