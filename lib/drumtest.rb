# drumtest.rb
# is for testing drum output to the Roland U-110

require 'unimidi'
require 'drums110'

snare = Drums110::SD1
kick = Drums110::BD1
rim = Drums110::RS
ohat = Drums110::OHH1
chat = Drums110::CHH1
ride = Drums110::RCM

# Prompt the user to select an output
# output = UniMIDI::Output.gets

# just use the first MIDI output
output = UniMIDI::Output.open(:first)

# Drums are traditionally MIDI channel 10 of 1-16, MIDI messaging is 0-based
channel = 9

8.times do
  output.puts(0x90 | channel, kick, 100)  # note on
  output.puts(0x90 | channel, chat, 100)  # note on
  output.puts(0x90 | channel, ride, 100)  # note on
  sleep 0.125
  output.puts(0x90 | channel, chat, 100)  # note on
  sleep 0.125
  output.puts(0x90 | channel, snare, 100) # note on
  output.puts(0x90 | channel, chat, 100)  # note on
  sleep 0.125
  output.puts(0x90 | channel, ohat, 100)  # note on
  output.puts(0x90 | channel, kick, 100)  # note on
  sleep 0.125
  output.puts(0x80 | channel, ohat, 100)  # note off
end

sleep 2.0
output.puts(0x90 | channel, ride, 100) # note on)
sleep 1.0
output.puts(0xB0 | channel, 120, 0) # all sound off
