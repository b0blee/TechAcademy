#midi.rb by b0b

require 'unimidi'

class MIDI
  include UniMIDI

  def initialize
    # Prompt the user to select an output
    # @synth = UniMIDI::Output.gets
    # or just use the first MIDI output
    @synth = UniMIDI::Output.open(:first)
  end

  NOTE_ON = 0x90
  NOTE_OFF = 0x80
  BEND = 0xE0

  def noteOn(channel, midiNote, velocity)
    @synth.puts(NOTE_ON | channel, midiNote, velocity)
  end

  def noteOff(channel, midiNote)
    @synth.puts(NOTE_OFF | channel, midiNote, 0x00)
  end

  # if suspend is true, the current thread will sleep for the duration.
  # otherwise, it spins a Thread.  Then it sends a NOTE_OFF
  def timedOff(channel, midiNote, duration, suspend)
    if suspend
      sleep duration
      @synth.puts(NOTE_OFF | channel, midiNote, 0x00)
    else Thread.new {
        sleep duration
        @synth.puts(NOTE_OFF | channel, midiNote, 0x00)
      }
    end
  end

  def bend(channel, msb, lsb=0x00)
    @synth.puts(BEND | channel, lsb, msb)
  end

  # Microtonals are usually monophonic in midi because bend effects entire channel.
  # If suspend is true (the default), this method sleeps for the duration
  def playXen(pitch, velocity, duration, channel, suspend=true)
    noteOn(channel, pitch.midi, velocity)
    bend(channel, pitch.msb, pitch.lsb)
    timedOff(channel, pitch.midi, duration, suspend)
  end

  # play a regular MIDI note
  # If suspend is true (the default), this method sleeps for the duration
  # If suspend is false, it spins a Thread for the NOTE_OFF, allowing polyphony  
  def playMidi(midiNote, velocity, duration, channel, suspend=true)
    noteOn(channel, midiNote, velocity)
    timedOff(channel, midiNote, duration, suspend)
  end
end
