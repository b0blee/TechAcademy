# tempo.rb
# timing for The Technical Academy by b0b

class Tempo

  def initialize(bpm)
    @beatsPerMinute = bpm
    setup
  end

  public

  def bpm; @beatsPerMinute; end
  def bpm!(b)
    @beatsPerMinute = b
    setup
  end

  def dot(t); 1.5 * t; end
  def w; @whole; end
  def h; @half; end
  def q; @quarter; end
  def e; @eighth; end
  def s; @sixteenth; end

  private

  def setup
    @whole    = 240.0 / @beatsPerMinute
    @half     = 120.0 / @beatsPerMinute
    @quarter  =  60.0 / @beatsPerMinute
    @eighth   =  30.0 / @beatsPerMinute
    @sixteenth = 15.0 / @beatsPerMinute
  end
end

=begin
t = Tempo.new(120)
def t.test
  printf("%f %f %f %f %f\n", w, h, q, e, s)
  printf("%f %f %f %f %f\n", dot(w), dot(h), dot(q), dot(e), dot(s))
end

p t
t.test
t.bpm!(144)
p t
t.test
=end
