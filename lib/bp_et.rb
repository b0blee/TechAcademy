# bp_et.rb
# module creates the Bohlen Pierce musical scale pitches in equal temperament

require 'pitch.rb'

module BohlenPierceET
  private
    TRITAVE = 1901.96         # a 3/2 Tritave is 1901.96 cents
    HALF = TRITAVE / 13.0     # equally tempered Half step
    A440 = 69                 # MIDI 69 is A440

    def self.nextPitch(last)
      Pitch.new(last.midi, last.cents + HALF)
    end

  public
    A0 = Pitch.new(A440, -3 * TRITAVE)
    As0 = nextPitch A0; Bb0 = As0
    B0 = nextPitch Bb0
    C0 = nextPitch B0
    Cs0 = nextPitch C0; Db0 = Cs0
    D0 = nextPitch Db0
    E0 = nextPitch D0
    F0 = nextPitch E0
    Fs0 = nextPitch F0; Gb0 = Fs0
    G0 = nextPitch Fs0
    H0 = nextPitch G0
    Hs0 = nextPitch H0; Jb0 = Hs0
    J0 = nextPitch Hs0

    A1 = Pitch.new(A440, -2 * TRITAVE)
    As1 = nextPitch A1; Bb1 = As1
    B1 = nextPitch Bb1
    C1 = nextPitch B1
    Cs1 = nextPitch C1; Db1 = Cs1
    D1 = nextPitch Db1
    E1 = nextPitch D1
    F1 = nextPitch E1
    Fs1 = nextPitch F1; Gb1 = Fs1
    G1 = nextPitch Fs1
    H1 = nextPitch G1
    Hs1 = nextPitch H1; Jb1 = Hs1
    J1 = nextPitch Hs1

    A2 = Pitch.new(A440, -TRITAVE)
    As2 = nextPitch A2; Bb2 = As2
    B2 = nextPitch Bb2
    C2 = nextPitch B2
    Cs2 = nextPitch C2; Db2 = Cs2
    D2 = nextPitch Db2
    E2 = nextPitch D2
    F2 = nextPitch E2
    Fs2 = nextPitch F2; Gb2 = Fs2
    G2 = nextPitch Fs2
    H2 = nextPitch G2
    Hs2 = nextPitch H2; Jb2 = Hs2
    J2 = nextPitch Hs2

    A3 = Pitch.new(A440, 0.0)
    As3 = nextPitch A3; Bb3 = As3
    B3 = nextPitch Bb3
    C3 = nextPitch B3
    Cs3 = nextPitch C3; Db3 = Cs3
    D3 = nextPitch Db3
    E3 = nextPitch D3
    F3 = nextPitch E3
    Fs3 = nextPitch F3; Gb3 = Fs3
    G3 = nextPitch Fs3
    H3 = nextPitch G3
    Hs3 = nextPitch H3; Jb3 = Hs3
    J3 = nextPitch Hs3

    A4 = Pitch.new(A440, TRITAVE)
    As4 = nextPitch A4; Bb4 = As4
    B4 = nextPitch Bb4
    C4 = nextPitch B4
    Cs4 = nextPitch C4; Db4 = Cs4
    D4 = nextPitch Db4
    E4 = nextPitch D4
    F4 = nextPitch E4
    Fs4 = nextPitch F4; Gb4 = Fs4
    G4 = nextPitch Fs4
    H4 = nextPitch G4
    Hs4 = nextPitch H4; Jb4 = Hs4
    J4 = nextPitch Hs4

    A5 = Pitch.new(A440, 2 * TRITAVE)
    As5 = nextPitch A5
    B5 = nextPitch As5
    C5 = nextPitch B5

    # array of all 69 chromatic pitches, in order
    Chromatic = [ A0, As0, B0,
      C0, Cs0, D0, E0, F0, Fs0, G0, H0, Hs0, J0, A1, As1, B1,
      C1, Cs1, D1, E1, F1, Fs1, G1, H1, Hs1, J1, A2, As2, B2,
      C2, Cs2, D2, E2, F2, Fs2, G2, H2, Hs2, J2, A3, As3, B3,
      C3, Cs3, D3, E3, F3, Fs3, G3, H3, Hs3, J3, A4, As4, B4,
      C4, Cs4, D4, E4, F4, Fs4, G4, H4, Hs4, J4, A5, As5, B5, C5
    ]

    # array of all 48 Lamda mode pitches, in order
    Lambda = [ A0, B0,
      C0, D0, E0, F0, G0, H0, J0, A1, B1,
      C1, D1, E1, F1, G1, H1, J1, A2, B2,
      C2, D2, E2, F2, G2, H2, J2, A3, B3,
      C3, D3, E3, F3, G3, H3, J3, A4, B4,
      C4, D4, E4, F4, G4, H4, J4, A5, B5, C5
    ]

    def self.test
      p A0; p A1; p J1; p A2
      p J2; p A3; p J3; p A4
      p J4; p A5
    end
end
