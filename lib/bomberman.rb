require 'chingu'
require 'game_traits'
require 'bomb'


class Bomberman < Chingu::GameObject
  traits :bounding_circle, :collision_detection
  traits :velocity, :screen_warp, :vector
  traits :timer
  
  attr_accessor :rotation_speed

  def initialize(options={})
    super options.merge($window.width/2 => :x, $window.height/2 => :y) #, :image => Gosu::Image["bomberman_front.png"])
    self.image = Gosu::Image["bomberman_front.png"]
    self.zorder = 2
    self.angle = 180
    self.input = {:holding_left => :turn_left,:holding_right => :turn_right, :space => :drop_bomb, :holding_up => :turn_up, :holding_down => :turn_down}
    # FIXME still needs to be expressed as a delta
    #self.rotation_speed = 3
  end
  

  def turn_left
  	self.image = Gosu::Image["bomberman_left.png"]
    self.angle = 270
    #self.acceleration = vector(0.1)
    self.x -= 5
  end

  def turn_right
    self.image = Gosu::Image["bomberman_right.png"]
    self.angle = 90
    #self.acceleration = vector(0.1)
    self.x += 5
  end
  
  def turn_up
    self.image = Gosu::Image["bomberman_back.png"]
    self.angle = 0
    #self.acceleration = vector(0.1)
    self.y -= 5
  end
  
  def turn_down
    self.image = Gosu::Image["bomberman_front.png"]
    self.angle = 180
    #self.acceleration = vector(0.1)
    self.y += 5
  end

  def drop_bomb
    Bomb.create 0 => angle, :scale => scale, :x => x, :y => y, :velocity => velocity
    Gosu::Sound["blaster.wav"].play
  end
  
end

class AIbot < Bomberman
	
	def initialize(options={})
		super
		@target = Bomberman
		self.input = {}
		@color = Gosu::Color.new(0xff000000)
		@color.red = rand(255 - 40) + 40
		@color.green = rand(255 - 40) + 40
		@color.blue = rand(256 - 40) + 40
		@x = rand * 640
		@y = rand * 314
		@angle = rand * 359
	end
	
	def update
		
		self.velocity = vector(0.2)
	end
	
end
