#!/usr/bin/env ruby

# frozen_string_literal: true

# This class simulates a roulette game using the Martingale strategy.
class Roulette
  attr_reader :spin_count, :wins, :losses, :money

  # @param money [Integer] The initial amount of money the player has.
  # @param bet [Integer] The initial bet size.
  # @param max_spins [Integer] The maximum number of spins to simulate.
  def initialize(money, bet, max_spins)
    @money = money
    @bet = bet
    @max_spins = max_spins
    @spin_count = 0
    @wins = 0
    @losses = 0
  end

  def spin
    @spin_count += 1
    if rand(2).zero?
      @money += @bet
      @wins += 1
      @bet = 1
    else
      @money -= @bet
      @losses += 1
      @bet *= 2
    end
  end

  def play
    spin while @money.positive? && @spin_count < @max_spins
  end

  def results
    <<~RESULTS
      Results:
        Spins: #{@spin_count}
        Wins: #{@wins}
        Losses: #{@losses}
        Money: #{@money}
    RESULTS
  end
end

if __FILE__ == $PROGRAM_NAME
  # Create a new roulette game with $1000, a bet of $1, and a maximum of 1000 spins.
  game = Roulette.new(1000, 1, 1000)

  # Play the game.
  game.play

  # Show the results.
  puts game.results
end