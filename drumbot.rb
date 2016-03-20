#!/usr/bin/env ruby
#
# translation of Forth code DRUMBOT.F

$LOAD_PATH << './lib'
require 'midi.rb'
require 'drums110.rb'
require 'volume.rb'
require 'tempo.rb'

Midi = MIDI.new

class Drumbot
  include Drums110

  def initialize(channel=9)
    @channel = channel
    @volume = Volume.new(0, 100)
  end

  # Limbs
  Lfoot     = [ BD2, BD4 ]                # 2 hollow bass drums
  Clubfoot  = [ BD1 ]                     # the dead bass drum
  Tomhand   = [ LTT1, MTT1, HTT1 ]        # some tom toms
  Ridehand  = [ RCL, RCM, RCH ]           # some ride cymbals
  Crashhand = [ CCH, CCL ]                # some crash cymbals
  Snarehand = [ SD1, SD2 ]                # main snare drum
  Rotohand  = [ LTT3, MTT3, MTT3, HTT3, BD3 ] # rototoms

  def hit(limb, velocity)
    drum = limb[rand(limb.size)]
    Midi.noteOn(@channel, drum, velocity)
    return drum
  end

  def pound(limb, duration, air)
    @drumming = true
    Thread.new {
      volume = Volume.new(0, 100)
      while @drumming
        if air && ((rand(air)/16) >= 1)
          # TODO: pedal
          sleep duration
        else
          hit( limb, volume.walk! )
          sleep duration
        end
      end
    }
  end

  def drumbot4
    tempo = Tempo.new(125)
    w, h, q = tempo.w, tempo.h, tempo.q
    hit(Crashhand, 64)
    sleep q
    pound( Lfoot, q, false)
    pound( Clubfoot, w * 128.0 / 129.0, false)
    pound( Crashhand, w * 7.0 / 32.0, 180)
    sleep q
    pound( Snarehand, h, false)
    pound( Snarehand, w * 64.0 / 129.0, false)
    sleep q
    sleep w * 8192 / 129
    @drumming = false
    hit(Crashhand, 64)
    sleep w
  end

  def drumbot5
    tempo = Tempo.new(125)
    w, h, q, e = tempo.w, tempo.h, tempo.q, tempo.e
    pound( Clubfoot, q, 22)
    pound( Lfoot, w+q, false)
    pound( Crashhand, w * 7.0 / 19.0, 200)
    sleep h
    pound( Snarehand, w + q, false)
    pound( Snarehand, h + e, false)
    sleep e
    pound( Snarehand, e * 15.0, false)
    pound( Lfoot, e * 8.0, false)
    pound( Ridehand, e / 2.0, 22)
    sleep( h + e )
    pound( Snarehand, h + q, 0)
    sleep w * 8192 / 129
    @drumming = false
    hit(Crashhand, 64)
  end

end

bot = Drumbot.new(9)
bot.drumbot4
bot.drumbot5
