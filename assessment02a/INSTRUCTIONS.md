# Crazy Eights

## Rules

* You have **45min** for the assessment. Finish as much as you can.
* If you have a laptop with Ruby installed, please use that in
  preference to a workstation. Use a workstation if you don't have a
  laptop.
* DO NOT use the internet. You should be well prepared from the
  practice assessment.
* When finished, please **ZIP YOUR SOLUTIONS** (.tar.gz or .zip; no
  boutique formats, please) and **EMAIL THEM TO YOUR MENTOR**.  Also
  **CC instructors@appacademy.io**.
* **ASK FOR HELP** if you are unclear on what a spec asks, if you get
  stuck, or if a you think a spec is wrong and that your code should
  pass.
* **USE THE SPECIFIED API**. We have carefully guided you on the methods
  you'll need in `Deck` and `Pile` to let you easily write `AIPlayer`. Use
  these methods; you'll see that we use `stub` and `should_receive` in
  `ai_player_spec.rb` to setup objects for the test. You need to call the
  expected methods.

## Game Rules

* Players are initially dealt eight cards.
* The goal is to discard all your cards first.
* The discard pile contains one initial card.
* Play goes around in turns.
* Player may play either the same number as the top card in the
  discard pile, or the same suit.
* The player may also always play an eight of any suit, in which case
  they also get to specify a new suit to play next round.

Further game rules are described on [Wikipedia][crazy-eight-rules], but the
above is the limit of what you need to implement.

[crazy-eight-rules]: http://en.wikipedia.org/wiki/Crazy_eights

## RSpec/Rakefile

Solve the classes in order:

    rake spec spec/deck_spec.rb
    rake spec spec/pile_spec.rb
    rake spec spec/ai_player_spec.rb
    rake spec spec/integration_specs.rb

Don't try to solve everything at once (`rake spec`) or you'll be overwhelmed
with a litany of errors to fix.
