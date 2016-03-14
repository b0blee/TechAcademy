#!/usr/bin/env ruby
#
# reimagining Terry Riley's "In C" with the Bohlen-Pierce Moll I (delta) mode
# copyright 2016 by Bob Lee a.k.a. -b0b-

$LOAD_PATH << './lib'
require 'midi.rb'
require 'bp_ji.rb'
require 'volume.rb'
require 'b0b.rb'
require 'drums110.rb'
require 'tempo.rb'

Midi = MIDI.new

class Note
  def initialize( pitch, duration, grace=false)
    @pitch, @duration, @grace = pitch, duration, grace
  end

  def duration; @duration; end

  def play( tempo, velocity, channel)
    length = tempo.w * @duration
    if @pitch
      if @grace
        velocity = velocity / 2
      end
      Midi.playXen( @pitch, velocity, length, channel)
    else
      sleep length
    end
  end
end

class In_odd
  include BohlenPierceJI

  # conveniences for scoring the 53 parts
  def self.note(pitch, duration); Note.new( pitch, duration); end
  def self.rest(duration);        Note.new( nil, duration);   end

  def self.n1(pitch, grace=false);    Note.new( pitch, 1.0, grace);    end
  def self.n2(pitch, grace=false);    Note.new( pitch, 0.5, grace);    end
  def self.n4(pitch, grace=false);    Note.new( pitch, 0.25, grace);   end
  def self.n8(pitch, grace=false);    Note.new( pitch, 0.125, grace);  end
  def self.n16(pitch, grace=false);   Note.new( pitch, 0.0625, grace); end
  def self.n32(pitch, grace=false);   Note.new( pitch, 0.03125, grace); end
  def self.dot2(pitch, grace=false);  Note.new( pitch, 0.75, grace);   end
  def self.dot4(pitch, grace=false);  Note.new( pitch, 0.375, grace);  end
  def self.dot8(pitch, grace=false);  Note.new( pitch, 0.1875, grace);  end
  def self.dot16(pitch, grace=false); Note.new( pitch, 0.09375, grace);  end
  def self.dot32(pitch, grace=false); Note.new( pitch, 0.046875, grace);  end

  # Note: Riley's middle C maps to the Bohlen-Pierce A2 note
  Part1 = [ n16(A2,true), dot8(C2), n16(A2,true), dot8(C2), n16(A2,true), dot8(C2) ]
  Part2 = [ n32(A2,true), dot16(C2), n8(D2), n4(C2) ]
  Part3 = [ n8(nil), n8(C2), n8(D2), n8(C2) ]
  Part4 = [ n8(nil), n8(C2), n8(D2), n8(F2) ]
  Part5 = [ n8(C2), n8(D2), n8(F2), n8(nil) ]
  Part6 = [ note(A3, 2.0) ]
  Part7 = [ note(nil, 0.875), n16(A2), n16(A2), n8(A2), note(nil, 0.875) ]
  Part8 = [ note(F2, 1.5), note(D2, 2.0) ]
  Part9 = [ n16(Jf2), n16(F2), note(nil, 0.875) ]
  Part10 = [ n16(Jf2), n16(F2) ]
  Part11 = [ n16(D2), n16(F2), n16(Jf2), n16(F2), n16(Jf2), n16(F2) ]
  Part12 = [ n8(D2), n8(F2), n1(Jf2), n4(A3) ]
  Part13 = [ n16(Jf2), dot8(F2), n16(F2), n16(D2), n8(F2), dot8(nil), note(F2, 0.8125) ]
  Part14 = [ n1(A3), n1(Jf2), n1(F2), n1(E2) ]
  Part15 = [ n16(F2), note(nil, 0.9375) ]
  Part16 = [ n16(F2), n16(Jf2), n16(A3), n16(Jf2) ]
  Part17 = [ n16(Jf2), n16(A3), n16(Jf2), n16(A3), n16(Jf2), n32(nil) ]
  Part18 = [ n16(C2), n16(E2), n16(C2), n16(E2), dot8(C2), n16(C2) ]
  Part19 = [ dot4(nil), dot4(C3) ]
  Part20 = [ n16(C2), n16(E2), n16(C2), n16(E2), dot8(G1), n16(C2), \
    n16(E2), n16(C2), n16(E2), n16(C2) ]
  Part21 = [ dot2(E2) ]
  Part22 = [ dot4(C2), dot4(C2), dot4(C2), dot4(C2), dot4(C2), \
    dot4(E2), dot4(F2), dot4(G2), n8(Jf2) ]
  Part23 = [ n8(C2), dot4(E2), dot4(E2), dot4(E2), dot4(E2), dot4(E2), \
    dot4(F2), dot4(G2), n8(Jf2) ]
  Part24 = [ n8(C2), n8(E2), dot4(F2), dot4(F2), dot4(F2), dot4(F2), \
    dot4(F2), dot4(G2), n8(Jf2) ]
  Part25 = [ n8(C2), n8(E2), n8(F2), dot4(G2), dot4(G2), dot4(G2), \
    dot4(G2), dot4(G2), dot4(Jf2) ]
  Part26 = [ n8(C2), n8(E2), n8(F2), n8(G2), dot4(Jf2), dot4(Jf2), \
    dot4(Jf2), dot4(Jf2), dot4(Jf2) ]
  Part27 = [ n16(C2), n16(E2), n16(C2), n16(E2), n8(F2), n16(C2), n16(F2), \
    n16(E2), n16(C2), n16(E2), n16(C2) ]
  Part28 = [ n16(C2), n16(E2), n16(C2), n16(E2), dot8(C2), n16(C2) ]
  Part29 = [ dot2(C2), dot2(F2), dot2(A3) ]
  Part30 = [ note(A3, 1.5) ]
  Part31 = [ n16(F2), n16(D2), n16(F2), n16(Jf2), n16(F2), n16(Jf2) ]
  Part32 = [ n16(D2), n16(F2), n16(D2), n16(F2), n16(Jf2), \
    note(D2, 0.8125), dot4(F2) ]
  Part33 = [ n16(F2), n16(D2), n8(nil) ]
  Part34 = [ n16(F2), n16(D2) ]
  Part35 = [ n16(D2), n16(F2), n16(Jf2), n16(F2), n16(Jf2), n16(F2), \
    n16(Jf2), n16(F2), n16(Jf2), n16(F2), n8(nil), n4(nil), n4(nil), n4(nil), \
    n4(H2), dot2(F3), n8(G3), n4(F3), n8(H3), dot4(G3), n8(F3), dot2(C3), \
    n8(F3), note(E3, 0.875), n4(nil), n4(nil), n8(nil),
    note(C3, 0.625), note(D3, 1.5) ]
  Part36 = [ n16(D2), n16(F2), n16(Jf2), n16(F2), n16(Jf2), n16(F2) ]
  Part37 = [ n16(D2), n16(F2) ]
  Part38 = [ n16(D2), n16(F2), n16(Jf2) ]
  Part39 = [ n16(Jf2), n16(F2), n16(D2), n16(F2), n16(Jf2), n16(A3) ]
  Part40 = [ n16(Jf2), n16(D2) ]
  Part41 = [ n16(Jf2), n16(F2) ]
  Part42 = [ n1(A3), n1(Jf2), n1(G2), n1(A3) ]
  Part43 = [ n16(D3), n16(C3), n16(D3), n16(C3), n8(C3), n8(C3), \
    n8(C3), n16(D3), n16(C3) ]
  Part44 = [ n8(D3), n4(C3), n8(C3), n4(A3) ]
  Part45 = [ n4(B3), n4(B3), n4(F2) ]
  Part46 = [ n16(F2), n16(B3), n16(C3), n16(B3), n8(nil), n8(F2), \
    n8(nil), n8(F2), n8(nil), n8(F2), n16(F2), n16(B3), n16(C3), n16(B3) ]
  Part47 = [ n16(B3), n16(C3), n8(B3) ]
  Part48 = [ note(F2, 1.5), note(F2, 1.0), note(D2, 1.25) ]
  Part49 = [ n16(D2), n16(F2), n16(H2), n16(F2), n16(H2), n16(F2) ]
  Part50 = [ n16(D2), n16(F2) ]
  Part51 = [ n16(D2), n16(F2), n16(H2) ]
  Part52 = [ n16(F2), n16(H2) ]
  Part53 = [ n16(H2), n16(F2) ]

  Score = [ Part1, Part2, Part3, Part4, Part5, Part6, Part7, Part8, Part9, \
    Part10, Part11, Part12, Part13, Part14, Part15, Part16, Part17, Part18, \
    Part19, Part20, Part21, Part22, Part23, Part24, Part25, Part26, Part27, \
    Part28, Part29, Part30, Part31, Part32, Part33, Part34, Part35, Part36, \
    Part37, Part38, Part39, Part40, Part41, Part42, Part43, Part44, Part45, \
    Part46, Part47, Part48, Part49, Part50, Part51, Part52, Part53 ]

  def playScore(channel)
    Score.each do |part|
      limit = 3.0 + rand(2)
      running = 0.0
      while running < limit do
        part.each do |note|
          note.play( @tempo, 0x40, channel);
          running += note::duration
        end
      end
    end
  end

  def perform( bpm)
    @tempo = Tempo.new( bpm)
    t0 = Thread.new {
      playScore(0)
    }
    t1 = Thread.new {
      playScore(1)
    }
    t2 = Thread.new {
      playScore(2)
    }
    t3 = Thread.new {
      playScore(3)
    }
    t4 = Thread.new {
      playScore(4)
    }

    playScore(5)

    while t0.alive? or t1.alive? or t2.alive? or t3.alive? or t4.alive?
     sleep 0.25
    end
  end
end

go = In_odd.new
go.perform 100
