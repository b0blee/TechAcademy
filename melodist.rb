#!/usr/bin/env ruby
#
# a class to generate melodies

$LOAD_PATH << './lib'
require 'midi.rb'
require 'tempo.rb'
require 'bp_ji.rb'

Midi = MIDI.new

module Melodist
  include BohlenPierceJI

  Half = 0.5
  Dotquarter = 0.375
  Quarter = 0.25
  Eighth = 0.125
  Sixteenth = 0.0625

  def self.test
    p Half
  end

end

Melodist.test
