require "highline/import"

module Diceroll
  class BasicConsole
    def start_game(game)
      game.add_player ask("player 1's name? ")
      game.add_player ask("player 2's name? ")
      game.start

      loop do
        say "name:  #{game.current_player_name}"
        say "score: #{game.current_player_score}"
        say "roll:  #{game.current_dice.join(", ")}"

        if game.current_rolls == game.max_rolls
          say "max rolls reached."
          say "#{game.current_dice_score} will be added to your score"
          say "next players turn."
          game.next_turn
          next
        end

        choose do |menu|
          menu.shell = true
          
          menu.choice(:reroll) do |command, details|
            keepers = details.split.map{|i| game.current_dice[i.to_i-1]}
            if keepers.size > 3
              say "keeping too many dice"
              next
            end
            game.reroll keepers
          end

          menu.choice(:pass) do
            say "#{game.current_dice_score} will be added to your score"
            say "next players turn."
            game.next_turn
          end

          menu.choice(:quit) do
            say "final scores:"
            game.players.each do |name|
              say "#{name}: #{game.score_for(name)}"
            end
            exit
          end
        end

      end
    end
  end
end
