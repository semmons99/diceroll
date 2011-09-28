module Diceroll
  class GameEngine

    class NotEnoughPlayers < StandardError; end
    class TooManyRolls < StandardError; end
    class TooManyKeepers < StandardError; end

    MAX_ROLLS       = 3
    MINIMUM_PLAYERS = 2

    attr_reader :current_dice, :current_rolls

    def current_player_name
      @current_player.name
    end

    def current_player_score
      @current_player.score
    end

    def current_dice_score
      @current_dice.reduce &:+
    end

    def players
      @players.map &:name
    end

    def number_of_players
      @players.size
    end

    def score_for(name)
      @players.select{|p| p.name == name}.first.score
    end

    def initialize(console = BasicConsole.new)
      @players = []
      console.start_game(self)
    end

    def add_player(name)
      @players << Player.new(name)
      name
    end

    def start
      raise NotEnoughPlayers unless @players.size >= MINIMUM_PLAYERS
      next_player
    end

    def reroll(keepers = [])
      raise TooManyRolls if @current_rolls >= 3
      raise TooManyKeepers if keepers.size > 3
      @current_dice = keepers + roll_dice(6 - keepers.size)
    end

    def next_turn
      tally_score
      next_player
    end

    def max_rolls
      MAX_ROLLS
    end

    def minimum_players
      MINIMUM_PLAYERS
    end

    private

    def next_player
      @current_player = @players.first
      @players.rotate!
      @current_rolls = 0
      @current_dice = roll_dice
    end

    def tally_score
      @current_player.score += @current_dice.reduce &:+
    end

    def roll_dice(n = 6)
      @current_rolls += 1
      n.times.map{ rand(6)+1 }
    end
  end
end
