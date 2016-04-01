# edo19.rb
# module creates the musical scale pitches for 19 equal divisions per octave

require_relative 'pitch.rb'

module EDO_19
  private
    THIRD = 1200.0 / 19.0     # if 12EDO has half steps, think of 19EDO as third steps
    A440 = 69                 # MIDI 69 is 440 Hz (A4)

    def self.nextHigher(pitch)
      Pitch.new(pitch.midi, pitch.cents + THIRD)
    end

    def self.octaveHigher(pitch)
      Pitch.new(pitch.midi + 12, pitch.cents)
    end

  public
    # The 19 tones are named C C# Db D D# Eb E E# F F# Gb G G# Ab A A# Bb B B#.
    # Note that there is no Fb and no Cb.
    A0 = Pitch.new(A440 - 48) # A0 is 4 octaves below A440
    As0 = nextHigher(A0)
    Bb0 = nextHigher(As0)
    B0 = nextHigher(Bb0)
    Bs0 = nextHigher(B0)
    C1 = nextHigher(Bs0)    # octave numbers traditionally start on the C note
    Cs1 = nextHigher(C1)    # we have to use 's' instead of '#' in Ruby constant names
    Db1 = nextHigher(Cs1);      D1 = nextHigher(Db1);     Ds1 = nextHigher(D1)
    Eb1 = nextHigher(Ds1);      E1 = nextHigher(Eb1);     Es1 = nextHigher(E1)
                                F1 = nextHigher(Es1);     Fs1 = nextHigher(F1)
    Gb1 = nextHigher(Fs1);      G1 = nextHigher(Gb1);     Gs1 = nextHigher(G1)
    Ab1 = nextHigher(Gs1);      A1 = nextHigher(Ab1);     As1 = nextHigher(A1)
    Bb1 = nextHigher(As1);      B1 = nextHigher(Bb1);     Bs1 = nextHigher(B1)
                                C2 = octaveHigher(C1);    Cs2 = octaveHigher(Cs1)
    Db2 = octaveHigher(Db1);    D2 = octaveHigher(D1);    Ds2 = octaveHigher(Ds1)
    Eb2 = octaveHigher(Eb1);    E2 = octaveHigher(E1);    Es2 = octaveHigher(Es1)
                                F2 = octaveHigher(F1);    Fs2 = octaveHigher(Fs1)
    Gb2 = octaveHigher(Gb1);    G2 = octaveHigher(G1);    Gs2 = octaveHigher(Gs1)
    Ab2 = octaveHigher(Ab1);    A2 = octaveHigher(A1);    As2 = octaveHigher(As1)
    Bb2 = octaveHigher(Bb1);    B2 = octaveHigher(B1);    Bs2 = octaveHigher(Bs1)
                                C3 = octaveHigher(C2);    Cs3 = octaveHigher(Cs2)
    Db3 = octaveHigher(Db2);    D3 = octaveHigher(D2);    Ds3 = octaveHigher(Ds2)
    Eb3 = octaveHigher(Eb2);    E3 = octaveHigher(E2);    Es3 = octaveHigher(Es2)
                                F3 = octaveHigher(F2);    Fs3 = octaveHigher(Fs2)
    Gb3 = octaveHigher(Gb2);    G3 = octaveHigher(G2);    Gs3 = octaveHigher(Gs2)
    Ab3 = octaveHigher(Ab2);    A3 = octaveHigher(A2);    As3 = octaveHigher(As2)
    Bb3 = octaveHigher(Bb2);    B3 = octaveHigher(B2);    Bs3 = octaveHigher(Bs2)
                                C4 = octaveHigher(C3);    Cs4 = octaveHigher(Cs3)
    Db4 = octaveHigher(Db3);    D4 = octaveHigher(D3);    Ds4 = octaveHigher(Ds3)
    Eb4 = octaveHigher(Eb3);    E4 = octaveHigher(E3);    Es4 = octaveHigher(Es3)
                                F4 = octaveHigher(F3);    Fs4 = octaveHigher(Fs3)
    Gb4 = octaveHigher(Gb3);    G4 = octaveHigher(G3);    Gs4 = octaveHigher(Gs3)
    Ab4 = octaveHigher(Ab3);    A4 = octaveHigher(A3);    As4 = octaveHigher(As3)
    Bb4 = octaveHigher(Bb3);    B4 = octaveHigher(B3);    Bs4 = octaveHigher(Bs3)
                                C5 = octaveHigher(C4);    Cs5 = octaveHigher(Cs4)
    Db5 = octaveHigher(Db4);    D5 = octaveHigher(D4);    Ds5 = octaveHigher(Ds4)
    Eb5 = octaveHigher(Eb4);    E5 = octaveHigher(E4);    Es5 = octaveHigher(Es4)
                                F5 = octaveHigher(F4);    Fs5 = octaveHigher(Fs4)
    Gb5 = octaveHigher(Gb4);    G5 = octaveHigher(G4);    Gs5 = octaveHigher(Gs4)
    Ab5 = octaveHigher(Ab4);    A5 = octaveHigher(A4);    As5 = octaveHigher(As4)
    Bb5 = octaveHigher(Bb4);    B5 = octaveHigher(B4);    Bs5 = octaveHigher(Bs4)
                                C6 = octaveHigher(C5);    Cs6 = octaveHigher(Cs5)
    Db6 = octaveHigher(Db5);    D6 = octaveHigher(D5);    Ds6 = octaveHigher(Ds5)
    Eb6 = octaveHigher(Eb5);    E6 = octaveHigher(E5);    Es6 = octaveHigher(Es5)
                                F6 = octaveHigher(F5);    Fs6 = octaveHigher(Fs5)
    Gb6 = octaveHigher(Gb5);    G6 = octaveHigher(G5);    Gs6 = octaveHigher(Gs5)
    Ab6 = octaveHigher(Ab5);    A6 = octaveHigher(A5);    As6 = octaveHigher(As5)
    Bb6 = octaveHigher(Bb5);    B6 = octaveHigher(B5);    Bs6 = octaveHigher(Bs5)
                                C7 = octaveHigher(C6);    Cs7 = octaveHigher(Cs6)
    Db7 = octaveHigher(Db6);    D7 = octaveHigher(D6);    Ds7 = octaveHigher(Ds6)
    Eb7 = octaveHigher(Eb6);    E7 = octaveHigher(E6);    Es7 = octaveHigher(Es6)
                                F7 = octaveHigher(F6);    Fs7 = octaveHigher(Fs6)
    Gb7 = octaveHigher(Gb6);    G7 = octaveHigher(G6);    Gs7 = octaveHigher(Gs6)
    Ab7 = octaveHigher(Ab6);    A7 = octaveHigher(A6);    As7 = octaveHigher(As6)
    Bb7 = octaveHigher(Bb6);    B7 = octaveHigher(B6);    Bs7 = octaveHigher(Bs6)
                                C8 = octaveHigher(C7)

    AllEdo19Notes = [
      A0, As0, Bb0, B0, Bs0,
      C1, Cs1, Db1, D1, Ds1, Eb1, E1, Es1, F1, Fs1, Gb1, G1, Gs1, Ab1, A1, As1, Bb1, B1, Bs1,
      C2, Cs2, Db2, D2, Ds2, Eb2, E2, Es2, F2, Fs2, Gb2, G2, Gs2, Ab2, A2, As2, Bb2, B2, Bs2,
      C3, Cs3, Db3, D3, Ds3, Eb3, E3, Es3, F3, Fs3, Gb3, G3, Gs3, Ab3, A3, As3, Bb3, B3, Bs3,
      C4, Cs4, Db4, D4, Ds4, Eb4, E4, Es4, F4, Fs4, Gb4, G4, Gs4, Ab4, A4, As4, Bb4, B4, Bs4,
      C5, Cs5, Db5, D5, Ds5, Eb5, E5, Es5, F5, Fs5, Gb5, G5, Gs5, Ab5, A5, As5, Bb5, B5, Bs5,
      C6, Cs6, Db6, D6, Ds6, Eb6, E6, Es6, F6, Fs6, Gb6, G6, Gs6, Ab6, A6, As6, Bb6, B6, Bs6,
      C7, Cs7, Db7, D7, Ds7, Eb7, E7, Es7, F7, Fs7, Gb7, G7, Gs7, Ab7, A7, As7, Bb7, B7, Bs7,
      C8
    ]
end
