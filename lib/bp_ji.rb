# bp_ji.rb
# module creates the Bohlen Pierce musical scale pitches as ratios

require 'pitch.rb'

module BohlenPierceJI
  private
    def self.makePitch(freq)
      midif = 12.0 * Math.log2(freq / 440.0) + 69.0
      midi = midif.to_i
      cents = (midif % 1.0) * 100.0
      Pitch.new(midi, cents)
    end

    c3Hz = 440.0 * 9.0 / 7.0   # freq of the C above A440 (A3)
    c2Hz = c3Hz / 3.0
    c1Hz = c2Hz / 3.0
    c0Hz = c1Hz / 3.0
    c4Hz = c3Hz * 3.0

  public
    C0 = makePitch( c0Hz )
    Cs0 = makePitch( c0Hz * 27.0 / 25.0 ); Df0 = Cs0
    D0 = makePitch( c0Hz * 25.0 / 21.0 )
    E0 = makePitch( c0Hz * 9.0 / 7.0 )
    F0 = makePitch( c0Hz * 7.0 / 5.0 )
    Fs0 = makePitch( c0Hz * 75.0 / 49.0 ); Gf0 = Fs0
    G0 = makePitch( c0Hz * 5.0 / 3.0 )
    H0 = makePitch( c0Hz * 9.0 / 5.0 )
    Hs0 = makePitch( c0Hz * 49.0 / 25.0 ); Jf0 = Hs0
    J0 = makePitch( c0Hz * 15.0 / 7.0 )
    A1 = makePitch( c0Hz * 7.0 / 3.0 )
    As1 = makePitch( c0Hz * 63.0 / 25.0 ); Bf1 = As1
    B1 = makePitch( c0Hz * 25.0 / 9.0 )

    C1 = makePitch( c1Hz )
    Cs1 = makePitch( c1Hz * 27.0 / 25.0 ); Df1 = Cs1
    D1 = makePitch( c1Hz * 25.0 / 21.0 )
    E1 = makePitch( c1Hz * 9.0 / 7.0 )
    F1 = makePitch( c1Hz * 7.0 / 5.0 )
    Fs1 = makePitch( c1Hz * 75.0 / 49.0 ); Gf1 = Fs1
    G1 = makePitch( c1Hz * 5.0 / 3.0 )
    H1 = makePitch( c1Hz * 9.0 / 5.0 )
    Hs1 = makePitch( c1Hz * 49.0 / 25.0 ); Jf1 = Hs1
    J1 = makePitch( c1Hz * 15.0 / 7.0 )
    A2 = makePitch( c1Hz * 7.0 / 3.0 )
    As2 = makePitch( c1Hz * 63.0 / 25.0 ); Bf2 = As2
    B2 = makePitch( c1Hz * 25.0 / 9.0 )

    C2 = makePitch( c2Hz )
    Cs2 = makePitch( c2Hz * 27.0 / 25.0 ); Df2 = Cs2
    D2 = makePitch( c2Hz * 25.0 / 21.0 )
    E2 = makePitch( c2Hz * 9.0 / 7.0 )
    F2 = makePitch( c2Hz * 7.0 / 5.0 )
    Fs2 = makePitch( c2Hz * 75.0 / 49.0 ); Gf2 = Fs2
    G2 = makePitch( c2Hz * 5.0 / 3.0 )
    H2 = makePitch( c2Hz * 9.0 / 5.0 )
    Hs2 = makePitch( c2Hz * 49.0 / 25.0 ); Jf2 = Hs2
    J2 = makePitch( c2Hz * 15.0 / 7.0 )
    A3 = makePitch( c2Hz * 7.0 / 3.0 )
    As3 = makePitch( c2Hz * 63.0 / 25.0 ); Bf3 = As3
    B3 = makePitch( c2Hz * 25.0 / 9.0 )

    C3 = makePitch( c3Hz )
    Cs3 = makePitch( c3Hz * 27.0 / 25.0 ); Df3 = Cs3
    D3 = makePitch( c3Hz * 25.0 / 21.0 )
    E3 = makePitch( c3Hz * 9.0 / 7.0 )
    F3 = makePitch( c3Hz * 7.0 / 5.0 )
    Fs3 = makePitch( c3Hz * 75.0 / 49.0 ); Gf3 = Fs3
    G3 = makePitch( c3Hz * 5.0 / 3.0 )
    H3 = makePitch( c3Hz * 9.0 / 5.0 )
    Hs3 = makePitch( c3Hz * 49.0 / 25.0 ); Jf3 = Hs3
    J3 = makePitch( c3Hz * 15.0 / 7.0 )
    A4 = makePitch( c3Hz * 7.0 / 3.0 )
    As4 = makePitch( c3Hz * 63.0 / 25.0 ); Bf4 = As4
    B4 = makePitch( c3Hz * 25.0 / 9.0 )

    C4 = makePitch( c4Hz )
    Cs4 = makePitch( c4Hz * 27.0 / 25.0 ); Df4 = Cs4
    D4 = makePitch( c4Hz * 25.0 / 21.0 )
    E4 = makePitch( c4Hz * 9.0 / 7.0 )
    F4 = makePitch( c4Hz * 7.0 / 5.0 )
    Fs4 = makePitch( c4Hz * 75.0 / 49.0 ); Gf4 = Fs4
    G4 = makePitch( c4Hz * 5.0 / 3.0 )
    H4 = makePitch( c4Hz * 9.0 / 5.0 )
    Hs4 = makePitch( c4Hz * 49.0 / 25.0 ); Jf4 = Hs4
    J4 = makePitch( c4Hz * 15.0 / 7.0 )
    A5 = makePitch( c4Hz * 7.0 / 3.0 )
    As5 = makePitch( c4Hz * 63.0 / 25.0 ); Bf5 = As5
    B5 = makePitch( c4Hz * 25.0 / 9.0 )
    C5 = makePitch( c4Hz * 3.0 )

    # array of all 66 chromatic pitches, in order
    Chromatic = [
      C0, Cs0, D0, E0, F0, Fs0, G0, H0, Hs0, J0, A1, As1, B1,
      C1, Cs1, D1, E1, F1, Fs1, G1, H1, Hs1, J1, A2, As2, B2,
      C2, Cs2, D2, E2, F2, Fs2, G2, H2, Hs2, J2, A3, As3, B3,
      C3, Cs3, D3, E3, F3, Fs3, G3, H3, Hs3, J3, A4, As4, B4,
      C4, Cs4, D4, E4, F4, Fs4, G4, H4, Hs4, J4, A5, As5, B5, C5
    ]

    # array of all 46 Lamda mode pitches, in order
    Lambda = [
      C0, D0, E0, F0, G0, H0, J0, A1, B1,
      C1, D1, E1, F1, G1, H1, J1, A2, B2,
      C2, D2, E2, F2, G2, H2, J2, A3, B3,
      C3, D3, E3, F3, G3, H3, J3, A4, B4,
      C4, D4, E4, F4, G4, H4, J4, A5, B5, C5
    ]

    def self.test
      p A1
      p A2
      p A3
      p A4
      p A5
    end
end
