# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'simulation'

class TestRoulette < Minitest::Test
  def setup
    @game = Roulette.new(1000, 1, 1000)
  end

  def test_initial_state
    assert_equal 1000, @game.money
    assert_equal 0, @game.spin_count
    assert_equal 0, @game.wins
    assert_equal 0, @game.losses
  end

  def test_spin_win
    srand 0
    @game.spin
    assert_equal 1001, @game.money
    assert_equal 1, @game.spin_count
    assert_equal 1, @game.wins
    assert_equal 0, @game.losses
  end

  def test_spin_loss
    srand 1
    @game.spin
    assert_equal 999, @game.money
    assert_equal 1, @game.spin_count
    assert_equal 0, @game.wins
    assert_equal 1, @game.losses
  end

  def test_play
    @game.play
    assert_operator @game.spin_count, :>, 0
  end
end