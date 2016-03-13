#!/usr/bin/env ruby
# reimagining The Technical Academy's "Do Thing" using a Bohlen-Pierce scale

$LOAD_PATH << './lib'
require 'midi.rb'
require 'bp_ji.rb'
require 'volume.rb'
require 'b0b.rb'
require 'drums110.rb'
require 'tempo.rb'

class DoThing < MIDI
  include BohlenPierceJI
  include The_b0b
  include Drums110

  # U-110 patch P-02:Academy_49
  PianoChannel1 = 0
  PianoChannel2 = 1
  BassChannel = 2
  VibesChannel1 = 3
  VibesChannel2 = 4
  DrumChannel = 9

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
    sleep( brnd ? @t.w/147.0 : @t.w/127.0 )
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
    sleep( brnd ? @t.w/147.0 : @t.w/127.0 )
    limit = @its + 3
    (3..@its+3).each do |i|
      hesitated?
      n = AllDrums[ rand( AllDrums.size ) ]
      if n == BD1 || n == HC || n == CHIL
        next # avoiding bass drum 1, hand claps & chinese cymbal
      else
        # playMidi(n, vol.walk!, @t.q, DrumChannel, true)
        noteOn(DrumChannel, n, vol.walk!)
        sleep @t.q   # no note off in drums
      end
    end
    playMidi(bottom, vol.volume, @t.w, DrumChannel, true)
    sleep( brnd ? @t.w/147.0 : @t.w/127.0 )
  end

  def thing(its)
    @its = its
    piano1 = Thread.new {
      sleep( @t.w / 12.0 )
      whaXen( 23, 39, Volume.new( 0, 75 ), PianoChannel1)
    }
    piano2 = Thread.new {
      sleep( @t.w * 3.0 / 16.0 )
      whaXen( 26, 39, Volume.new( 0, 75 ), PianoChannel2)
    }
    bass = Thread.new {
      whaXen( 13, 26, Volume.new( 20, 100 ), BassChannel)
    }
    vibes1 = Thread.new {
      sleep @t.s
      whaXen( 26, 13, Volume.new( 0, 40 ), VibesChannel1)
    }
    vibes2 = Thread.new {
      sleep( @t.dot @t.e )
      whaXen( 32, 13, Volume.new( 0, 60 ), VibesChannel2)
    }
    drums = Thread.new {
      sleep @t.e
      whaDrums( BD2, Volume.new( 40, 90 ) )
    }

    sleep @t.w * 5.0 / 32.0
    whaDrums( SD1, Volume.new( 20, 80 ) )

    while piano1.alive? or piano2.alive? or bass.alive? \
      or vibes1.alive? or vibes2.alive? or drums.alive?
     sleep 0.25
    end
  end

  def perform(tempo)
    # assign U-110 voices
    voice( PianoChannel1, 8)  # a.piano.9
    voice( PianoChannel2, 8)
    voice( BassChannel, 50)   # ac.bass
    voice( VibesChannel1, 17) # vib.3
    voice( VibesChannel2, 17)
    voice( DrumChannel, 98)   # drums

    @t = Tempo.new(tempo)
    thing 36
    @t = Tempo.new(tempo * 1.25)
    thing 72
    @t = Tempo.new(tempo)
    thing 24
    @t = Tempo.new(tempo * 4.0 / 3.0)
    thing 96
    @t = Tempo.new(tempo * 2.0 / 3.0)
    thing 12
    thing 1
  end
end

go = DoThing.new
go.perform(180)
