# Drums110
# = drum note assignments for the Roland U-110
# written by b0b for The Technical Academy
# translated from Forth language DRUMS110.F
# last modified: 2016.02.19
#
# Forth syntax for translation reference
# note: Forthmacs z$ sounds a drum without advancing time
#
# :ap snare   SD1  z$ ;ap  ' snare is Snare
# :ap kick    BD1  z$ ;ap  ' kick  is Kick
# :ap rim     RS   z$ ;ap  ' rim   is Rim
# :ap ohat    OHH1 z$ ;ap  ' ohat  is oHat
# :ap chat    CHH1 z$ ;ap  ' chat  is cHat
# :ap ride    RCM  z$ ;ap  ' ride  is Ride

module Drums110
# terse mnemonics for each drum in the kit
  BD1 = 35    # bass drum 1
  BD2 = 36    # bass drum 2
  RS = 37     # rim shot
  SD1 = 38    # snare drum 1
  HC = 39     # hand clap
  SD2 = 40    # snare drum 2
  LTT1 = 41   # low tom tom 1
  CHH1 = 42   # closed high hat 1
  LTT2 = 43   # low tom tom 2
  OHH2 = 44   # open high hat 2
  MTT1 = 45   # middle tom tom 1
  OHH1 = 46   # open high hat 1
  MTT2 = 47   # middle tom tom 2
  HTT1 = 48   # high tom tom 1
  CCL = 49    # crash cymbal (low)
  HTT2 = 50   # high tom tom 2
  RCL = 51    # ride cymbal (low)
  CHIL = 52   # chinese cymbal (low)
  CUP = 53    # cup (muted cymbal)

  COWBELL = 56  # cowbell (more)
  CCH = 57    # crash cymbal (high)
  SD3 = 58    # snare drum 3
  RCH = 59    # ride cymbal (high)

  CABASA = 69 # cabasa

  HPTT2 = 79  # high pitch tom tom 2 (high)

  HPTT1 = 81  # high pitch tom tom 1 (higher)

  BD3 = 84    # bass drum 3
  BD4 = 85    # bass drum 4
  SD4 = 86    # snare drum 4
  SD5 = 87    # snare drum 5
  SD6 = 88    # snare drum 6
  LTT3 = 89   # low tom tom 3
  CHH2 = 90   # closed high hat 2
  MTT3 = 91   # middle tom tom 3
  CHIH = 92   # chinese cymbal (high)
  HTT3 = 93   # high tom tom 3
  RCM = 94    # ride cymbal (mid)

  AllDrums = [
    35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53,
    56, 57, 58, 59, 69, 79, 81,
    84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94
  ]
end
