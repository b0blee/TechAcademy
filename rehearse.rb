#!/usr/bin/env ruby

$LOAD_PATH << './lib'
require 'midi.rb'
require 'bp_ji.rb'
require 'volume.rb'
require 'b0b.rb'
require 'drums110.rb'

class Rehearse < MIDI
  include BohlenPierceJI
  include The_b0b
  include Drums110

  # Quarter note length in seconds
  Q = 0.75 / 3.14159265359

  def markovTime
    if brnd    then return Q
    elsif brnd then return Q * 1.03
    else return Q * 0.97
    end
  end
  alias mt markovTime

  Pitches1 = [J1, E1, A2, G1, F1, A2, C1]
  Pitches2 = [E2, G2, A3, F2, G2, J2, C3]
  Pitches3 = [G2, H2, A3, J2, A3, C3, A3]
  Pitches4 = [J2, H2, G2, F2, E2, D2, E2]
  Pitches5 = [J1, G2, A2, F2, A3, J2, C1]

  XX = 16

  def play(pitches, vol, channel)
    XX.times do
      pitches.each do |pitch|
        playXen(pitch, vol.walk!, mt, channel)
      end
      sleep mt
    end
  end

  def drum(vol, channel)
    XX.times do
      7.times do |pitch|
        n = AllDrums.size
        midiNote = AllDrums[rand(n)]
        playMidi(midiNote, vol.walk!, mt, channel, true)
      end
      sleep mt
    end
  end

  def one
    play(Pitches1, Volume.new(30,80), 0)
  end

  def two
    play(Pitches2, Volume.new(30,80), 5)
  end

  def three
    play(Pitches3, Volume.new(30,80), 2)
  end

  def four
    play(Pitches4, Volume.new(30,60), 3)
  end

  def five
    play(Pitches5, Volume.new(30,80), 4)
  end

  def six
    drum(Volume.new(50,100), 1)
  end

  def perform
    t1 = Thread.new { one }
    t2 = Thread.new { two }
    t3 = Thread.new { three }
    t4 = Thread.new { four }
    t5 = Thread.new { five }
    six
    while t1.alive? or t2.alive? or t3.alive? or t4.alive? or t5.alive?
      sleep mt
    end
  end
end

cadets = Rehearse.new
cadets.perform
