# volume.rb by b0b
# translation of The Technical Academy's VOLUME.F
require 'b0b.rb'

class Volume
  include The_b0b

  def initialize(minVolume=0, maxVolume=127)
    setRange(minVolume,maxVolume)
  end

  def setRange(minVolume, maxVolume)
    # make sure they're in the right order
    minv = [minVolume, maxVolume].min
    maxv = [minVolume, maxVolume].max
    # enforce bounds for instance variables
    @min = [minv, 0].max
    @max = [maxv, 127].min
    @volume = @min + rand(@max - @min).to_i
  end

  # Markov chain "drunkard's walk" changes @volume in small steps randomly
  def walk!
    if brnd
      step = (@max - @min) / 4.0
      x = (rand(step + 0.5) + 1.0).to_i
      @volume = brnd ? [@max, @volume + x].min : [@min, @volume - x].max
    else
      @volume
    end
  end

  def volume
    @volume
  end

  # sets @volume, within limits of defined range
  def volume=(value)
    @volume = [[value,@max].min, @min].max.to_i
  end

  # increases @volume, within limits of defined range
  def inc(amount=1)
    @volume = [@volume + 1,@max].min
  end

  # decreases @volume, within limits of defined range
  def dec(amount=1)
    @volume = [@volume - 1,@min].max
  end
end
