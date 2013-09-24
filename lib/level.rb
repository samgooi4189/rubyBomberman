require 'chingu'
require 'score'
require 'bomberman'
require 'flare'
require 'box'
include Gosu

class Level < Chingu::GameState
  def initialize
    super
    self.input = {:esc => :exit, :p => :pause, :e => :edit, :d => :debug}

    @lives = 3
    @score = 0
    @score_text = Chingu::Text.create(:x => 1, :y => 1, :size => 20)
    @lives_text = Chingu::Text.create(:x => 200, :y => 1, :size => 20)
    @instruction_text = Chingu::Text.create(:x => 200, :y =>550, :size => 20)
	@lock = 0
    load_game_objects
  end

  def edit
    push_game_state(Chingu::GameStates::Edit)
  end

  def debug
    push_game_state(Chingu::GameStates::Debug)
  end

  def pause
    push_game_state(Chingu::GameStates::Pause)
  end

  def update
    super

    Bomberman.each_collision (Flare) do |player, flare|
      flare.destroy!
      if @lock == 0 
      	@lives -= 1
      
      	if @lives > 0
			player.x = rand * $window.width
			player.y = rand * $window.height
      	else
			@lives = 3
			@score = 0
			push_game_state(Chingu::GameStates::Pause)
      	end
      end
      @lock = 1
    end
    @lock = 0

    Flare.each_collision(BoxTiny) do |flare, box|
      if @lock == 0
      	flare.destroy
      	

      	@score += box.score
      	box.x = rand * $window.width
		box.y = rand * $window.height
      end
    end
    @lock = 0

    @score_text.text = "score: #{@score}"
    @lives_text.text = "life: #{@lives}"
    @instruction_text.text = "Press <space> to drop bomb ~"
  end
end
