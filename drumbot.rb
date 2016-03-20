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

  def initialize(bpm=125, channel=9)
    @channel = channel
    @tempo = Tempo.new(bpm)
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

  def brnd
    rand(0) < 0.5
  end

  def pound(limb, duration, air)
    @drumming = true
    Thread.new {
      volume = Volume.new(0, 100)
      drum = false
      while @drumming
        if air && (( rand( air + 1 ) / 16 ) >= 1 )
          if drum && brnd
            Midi.noteOff(@channel, drum)
            drum = false
          end
        else
          if drum
            Midi.noteOff(@channel, drum)
            drum = false
          end
          drum = hit( limb, volume.walk! )
        end
        sleep duration
      end
    }
  end

  def drumbot4
    w, h, q = @tempo.w, @tempo.h, @tempo.q
    hit(Crashhand, 64)
    sleep q
    pound( Lfoot, q, false)
    pound( Clubfoot, w * 128.0 / 129.0, false)
    pound( Crashhand, w * 7.0 / 32.0, 180)
    sleep q
    pound( Snarehand, h, false)
    pound( Snarehand, w * 64.0 / 129.0, false)
  end

  def drumbot5
    w, h, q, e = @tempo.w, @tempo.h, @tempo.q, @tempo.e
    pound( Clubfoot, q, 22)
    pound( Lfoot, w + q, false)
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
  end

  def drumdub
    drumbot5
    drumbot5
    sleep (@tempo.q * 5) * 30
    @drumming = false
    hit(Crashhand, 64)
  end

  # After listening to the above, I don't think that the archival Forth code
  # is what was actually recorded as Drum Dub in 1990.
  # A new 5/4 drumbot jam follows

  def jam
    w, h, q, e = @tempo.w, @tempo.h, @tempo.q, @tempo.e   # conveniences
    pound( Clubfoot, h + e, 30 )
    pound( Lfoot, w + q, 30 )
    pound( Crashhand, q * 5.0, 150 )
    pound( Ridehand, h / 3.0, 30 )
    sleep( h )
    pound( Snarehand, w + q, 30 )
    pound( Snarehand, h + e, 30 )
    pound( brnd ? Tomhand : Rotohand, q, 100 )
    sleep( e )
    pound( brnd ? Tomhand : Rotohand, q, 100 )
    pound( Crashhand, q * 5.0, 150 )
    sleep( e )
  end

  def jams
    hit(Crashhand, 64)
    jam; jam;
    sleep @tempo.q * 5 * 30   # 30 measures
    @drumming = false
    hit(Crashhand, 64)
  end
end

bot = Drumbot.new(125,9)
bot.jams
