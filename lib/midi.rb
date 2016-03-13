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

  # MIDI channel messages
  NOTE_OFF = 0x80
  NOTE_ON = 0x90
  POLY_KEY_PRESSURE = 0xA0
  CONTROL_CHAGE = 0xB0
  PROGRAM_CHANGE = 0xC0
  CHANNEL_PRESSURE = 0xD0
  PITCH_BEND = 0xE0

  def noteOn(channel, midiNote, velocity)
    @synth.puts(NOTE_ON | channel, midiNote, velocity)
  end

  def noteOff(channel, midiNote)
    @synth.puts(NOTE_OFF | channel, midiNote, 0x00)
  end

  def voice(channel, instrument)
    @synth.puts(PROGRAM_CHANGE | channel, instrument)
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
    @synth.puts(PITCH_BEND | channel, lsb, msb)
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
