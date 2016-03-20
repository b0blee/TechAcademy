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

  def hit(limb)
    drum = limb[rand(limb.size)]
    Midi.noteOn(@channel, drum, @volume.walk!)
    return drum
  end

  def perform
    10.times do
        hit(Lfoot); sleep 0.25
        hit(Clubfoot);  sleep 0.25
        hit(Tomhand); sleep 0.25
        hit(Ridehand); sleep 0.25
        hit(Crashhand); sleep 0.25
        hit(Snarehand); sleep 0.25
        hit(Rotohand); sleep 0.25
    end
  end

end

bot = Drumbot.new(9)
bot.perform
