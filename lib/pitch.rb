# pitch.rb
# by b0b, Feb 2016

class Pitch
  def initialize(midiNumber, centsOffset=0)
    raise TypeError, "midiNumber must be an integer" if not midiNumber.is_a? Integer
    assign(midiNumber, centsOffset)
    midiShift!(200)
  end

  def midi;   @midi;  end   # range 0...127
  def cents;  @cents; end   # range 0..100
  # MIDI pitch bend bytes
  def msb;    @msb;   end   # range 0x00...0x7F
  def lsb;    @lsb;   end   # range 0x00...0x7F

  # midiShift - converts @cents to 14-bit MIDI pitch bend params
  #     This is called on initialization with the typical wheelMax of 200 cents.
  #     Call it again if that doesn't match your synth.
  # Params:
  # - wheelMax: number of cents the synth can move the note from center, default 200
  # Returns:
  # - @lsb, @msb (7 bits each) for MIDI pitch change messages
  def midiShift!(wheelMax)
    ratio = (@cents / wheelMax.to_f).abs
    bend = (ratio * 0x2000).to_i
    bend = @cents > 0 ? 0x2000 + bend : 0x2000 - bend
    @lsb, @msb = bend & 0x7F, bend >> 7
  end

  protected
  # recursive initializer guarantees that @midi is 0...127 and @cents is 0..100
  def assign(midiNumber, centsOffset)
    raise ArgumentError, "midiNumber out of range 0-127" if midiNumber < 0 || midiNumber > 127
    if centsOffset >= 100
      midiNumber += 1
      centsOffset -= 100
      assign(midiNumber, centsOffset); return
    elsif centsOffset < 0
      midiNumber -= 1
      centsOffset += 100
      assign(midiNumber, centsOffset); return
    end

    @midi = midiNumber
    @cents = centsOffset.round(4)
  end
=begin
  public def self.test
    p Pitch.new(64)
    p Pitch.new(64, 55)
    p Pitch.new(64, 33.75)
    p Pitch.new(64, 75.44)
    p Pitch.new(32, -20)
    p Pitch.new(32, -85.7)
    p Pitch.new(64, -1702.333333)
    p Pitch.new(0, 1702.00)
  end
=end
end
