#!/usr/bin/env ruby
# reimagining The Technical Academy's "Do Thing" using a Bohlen-Pierce scale

$LOAD_PATH << './lib'
require 'midi.rb'
require 'bp_ji.rb'
require 'volume.rb'
require 'b0b.rb'
require 'drums110.rb'
require 'tempo.rb'

class DoPhing < MIDI
  include BohlenPierceJI
  include The_b0b
  include Drums110

  PianoChannel = 0
  DrumChannel = 1
  StringChannel = 2
  BassChannel = 3
  HornChannel = 4
  ReedChannel = 5

  Pitches = Chromatic

  def hesitated?
    if brnd
      return false  # half the time we do nothing
    end
    sleep( brnd ? @t.w/147.0 : @t.w/127.0 )
    return true
  end

  # bottom is the index of the lowest note allowed in the Pitches array
  def whaXen(bottom, range, vol, channel)
    playXen(Pitches[bottom], vol.volume, @t.w, channel)
    (3..@its+3).each do |i|
      hesitated?
      r = rand(range)
      if r == 0 or r > Pitches.size
        if brnd
          sleep @t.q
        elsif brnd
            playXen(Pitches[bottom + rand(range)], vol.walk!, @t.q, channel)
        else
            playXen(Pitches[bottom], vol.walk!, @t.q, channel)
        end
      else
        playXen(Pitches[bottom+r], vol.walk!, @t.q, channel)
      end
    end
    playXen(Pitches[bottom], vol.volume, @t.w, channel)
    sleep( brnd ? @t.w/147.0 : @t.w/127.0 )
  end

  def whaDrums(bottom, vol)
    playMidi(bottom, vol.volume, @t.w, DrumChannel, true)
    limit = @its + 3
    (3..@its+3).each do |i|
      hesitated?
      n = AllDrums[ rand( AllDrums.size ) ]
      if n == BD1 || n == HC || n == CHIL
        next # avoiding bass drum 1, hand claps & chinese cymbal
      else
        playMidi(n, vol.walk!, @t.q, DrumChannel, true)
      end
    end
    playMidi(bottom, vol.volume, @t.w, DrumChannel, true)
    sleep( brnd ? @t.w/147.0 : @t.w/127.0 )
  end

  def phing(its)
    @its = its
    piano = Thread.new {
      sleep( @t.w / 12.0 )
      whaXen( 23, 39, Volume.new( 0, 75 ), PianoChannel)
    }
    string = Thread.new {
      sleep( @t.w * 3.0 / 16.0 )
      whaXen( 26, 39, Volume.new( 0, 75 ), StringChannel)
    }
    bass = Thread.new {
      whaXen( 13, 26, Volume.new( 20, 100 ), BassChannel)
    }
    horn = Thread.new {
      whaXen( 26, 13, Volume.new( 0, 40 ), HornChannel)
    }
    reed = Thread.new {
      whaXen( 32, 13, Volume.new( 0, 60 ), ReedChannel)
    }
    drums = Thread.new {
      sleep @t.e
      whaDrums( BD2, Volume.new( 40, 90 ) )
    }

    sleep @t.w * 5.0 / 32.0
    whaDrums( SD1, Volume.new( 20, 80 ) )

    while piano.alive? or string.alive? or bass.alive? or horn.alive? or
      reed.alive? or drums.alive?
     sleep 0.25
    end
  end

  def perform(tempo)
    @t = Tempo.new(tempo)
    phing 36
    @t = Tempo.new(tempo * 1.25)
    phing 72
    @t = Tempo.new(tempo)
    phing 24
    @t = Tempo.new(tempo * 4.0 / 3.0)
    phing 96
    @t = Tempo.new(tempo * 2.0 / 3.0)
    phing 12
    phing 1
  end
end

go = DoPhing.new
go.perform(199)
