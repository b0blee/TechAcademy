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
  Q = 1.0 / 3.14159265359

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
  Pitches6 = [J1, H2, A3, F2, F1, J2, A3]

  XX = 32

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
      sleep Q # mt
    end
  end

  def one( channel )
    play(Pitches1, Volume.new(20,120), channel)
  end

  def two( channel )
    play(Pitches2, Volume.new(20,120), channel)
  end

  def three( channel )
    play(Pitches3, Volume.new(20,120), channel)
  end

  def four( channel )
    play(Pitches4, Volume.new(20,120), channel)
  end

  def five( channel )
    play(Pitches5, Volume.new(20,120), channel)
  end

  def six( channel )
    play(Pitches6, Volume.new(20,120), channel)
  end

  def percussion( channel )
    drum(Volume.new(50,100), channel)
  end

  def perform
    # U-110
    Thread.new { one(0) }
    Thread.new { two(1) }
    Thread.new { three(2) }
    Thread.new { four(3) }
    Thread.new { five(4) }
    Thread.new { six(5) }
    # D-110
    Thread.new { one(6) }
    Thread.new { two(7) }
    Thread.new { three(8) }
    Thread.new { four(9) }
    Thread.new { five(10) }
    t = Thread.new { six(11) }
    percussion( 14 ) # drums
    while t.alive?
       sleep Q
    end
    sleep 1
  end
end

cadets = Rehearse.new
cadets.perform
