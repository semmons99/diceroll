Example of writing a game engine which is IO agnostic.

`Diceroll::GameEngine#initialize` is the only place where GameEngine is aware of a console, and there it calls a single `#start_game` method on the console and leaves the rest of the game to the console. It will enforce rules and keep track of the game state, but it will not prompt the user for information, or display anything itself.

Each console is responsible for getting input for the user and displaying the game state to the user. The game engine maintains and adjusts the game state based on actions the console tells it to take. If the console tries to break a rule, the game engine raises an exception. For example, if the console tries to start the game with too few players, an exception is raised.

To play with this do the following:

```shell
> git clone https://semmons99@github.com/semmons99/diceroll.git
> cd diceroll
> bundle install --path vendor/ruby
```

The rules are simple. You must have 2 or more players. Players take turns rolling 6 dice. They have 3 tosses to get the highest overall score. Each toss they may only keep up to 3 dice. There is no end to the game.

Run using the basic console. Note, when using the basic console and choosing reroll, you supply which dice you would like to keep by index (1 based).

```shell
> be ruby bin/diceroll basic
player 1's name? shane
player 2's name? dave
name:  shane
score: 0
roll:  1, 1, 6, 2, 3, 5
1. reroll
2. pass
3. quit
?  1 3 6
name:  shane
score: 0
roll:  6, 5, 5, 3, 3, 5
1. reroll
2. pass
3. quit
?  1 1 2 3 6
keeping too many dice
name:  shane
score: 0
roll:  6, 5, 5, 3, 3, 5
1. reroll
2. pass
3. quit
?  1 1 2 3
name:  shane
score: 0
roll:  6, 5, 5, 3, 5, 6
max rolls reached.
30 will be added to your score
next players turn.
name:  dave
score: 0
roll:  1, 4, 6, 6, 6, 3
1. reroll
2. pass
3. quit
?  2
26 will be added to your score
next players turn.
name:  shane
score: 30
roll:  3, 5, 3, 2, 1, 3
1. reroll
2. pass
3. quit
?  3
final scores:
dave: 26
shane: 30
```

Run using the pry console:

```shell
> be ruby bin/diceroll pry
1.9.2 (#<Diceroll::PryConsole:0x2e5a140>):0 > game.start
Diceroll::GameEngine::NotEnoughPlayers: Diceroll::GameEngine::NotEnoughPlayers from lib/diceroll/game_engine.rb:48:in `start'
1.9.2 (#<Diceroll::PryConsole:0x2e5a140>):0 > game.add_player "shane"
=> "shane"
1.9.2 (#<Diceroll::PryConsole:0x2e5a140>):0 > game.start
Diceroll::GameEngine::NotEnoughPlayers: Diceroll::GameEngine::NotEnoughPlayers from lib/diceroll/game_engine.rb:48:in `start'
1.9.2 (#<Diceroll::PryConsole:0x2e5a140>):0 > game.add_player "dave"
=> "dave"
1.9.2 (#<Diceroll::PryConsole:0x2e5a140>):0 > game.start
=> [4, 4, 4, 4, 6, 1]
1.9.2 (#<Diceroll::PryConsole:0x2e0a148>):0 > game.reroll [6,4,4,4]
Diceroll::GameEngine::TooManyKeepers: Diceroll::GameEngine::TooManyKeepers from lib/diceroll/game_engine.rb:54:in `reroll'
1.9.2 (#<Diceroll::PryConsole:0x2e5a140>):0 > game.reroll [6,4,4]
=> [6, 4, 4, 5, 4, 1]
1.9.2 (#<Diceroll::PryConsole:0x2e5a140>):0 > game.next_turn
=> [1, 3, 1, 4, 6, 2]
1.9.2 (#<Diceroll::PryConsole:0x2e5a140>):0 > game.current_player_name
=> "dave"
1.9.2 (#<Diceroll::PryConsole:0x2e5a140>):0 > game.score_for "shane"
=> 24
1.9.2 (#<Diceroll::PryConsole:0x2e5a140>):0 > exit
leaving pry...
```
