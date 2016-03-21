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
  Hihathand = [ OHH1, CHH1, OHH2, CHH2 ]

  def brnd
    rand(0) < 0.5
  end

  def pound(limb, duration, air, channel=9)
    @drumming = true
    Thread.new {
      volume = Volume.new( 0, 100 )
      drum = nil
      while @drumming
        if air && (( rand( air + 1 ) / 16 ) >= 1 )
          if drum && brnd
            Midi.noteOff( channel, drum )
            drum = nil
          # else # do nothing - drum may continue to sound
          end
        else
          if drum
            Midi.noteOff( channel, drum )
            drum = nil
          end
          drum = limb[rand(limb.size)]
          Midi.noteOn( channel, drum, volume.walk! )
        end
        sleep duration
      end
    }
  end
=begin original is obsolete
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
=end
  # After listening to the above, I don't think that the archival Forth code
  # is what was actually recorded as Drum Dub in 1990.
  # A new 5/4 drumbot jam follows

  def w; @tempo.w; end  # time of whole note
  def h; @tempo.h; end  # time of half note
  def q; @tempo.q; end  # time of quarter note
  def e; @tempo.e; end  # time of eighth note

  def jam
    pound( Clubfoot, h + e, 30 )
    pound( Crashhand, q * 5.0, 150 )
    pound( Ridehand, h / 3.0, 60 )
    pound( Hihathand, e, 20 )
    sleep( h )
    pound( Snarehand, w + q, 30 )
    pound( Snarehand, h + e, 30 )
    pound( brnd ? Tomhand : Rotohand, q, 100 )
    sleep( e )
    pound( brnd ? Tomhand : Rotohand, q, 100 )
    pound( Crashhand, q * 5.0, 150 )
    sleep( h )
    pound( Lfoot, w + q, 30 )
  end

  # limbs using SN-U110-10 rock drums card
  Rfoot2 = [ R_BD3, R_BD3 ]
  Lfoot2 = [ R_BD4, R_BD4 ]
  Rhand2 = [ R_RS, R_SD4, R_SD4, R_LT3, R_MT3, R_HT3, R_CH1, R_CH1, R_OH1 ]
  Lhand2 = [ R_SD4, R_SD4, R_LT3, R_MT3, R_HT3, R_HOH1, R_CC3 ]
  Whack = [ R_SD4, R_SD4 ]

  def rock # in 5/4 time
    pound( Rfoot2, q, nil, 0 )
    pound( Rhand2, e, 20, 0 )
    sleep( h )
    pound( Whack, w + q, nil, 0 )
    pound( Lfoot2, h, 40, 0 )
    sleep( e )
    pound( Rhand2, h + e, nil, 0 )
  end

  def jams
    Midi.noteOn( @channel, CCH, 64)
    rock; jam;
    sleep q * 5 * 30   # 30 measures
    @drumming = false
    Midi.noteOn( @channel, CCH, 64)
    sleep q * 5
  end
end

bot = Drumbot.new(140,9)
bot.jams
