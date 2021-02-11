# Dragon Spirit sound driver for SGDK

### What works

- Playing music

### What doesn't work

- Playing channels 7 and 8, since they're not present on YM2612.
  I might implement PSG support. The music data will have to be edited
  to make things fit within the MD's hardware limitations.

- LFO. YM2151 LFO is much more powerful than YM2612. Some edits to
  music data will need to be done here too I think.

- Samples & WSG. Could probably use the ADPCM samples from the X68K
  version, I think. WSG is not very likely to happen on the MD...

- Sound effects
  Shouldn't be too hard to implement. The original arcade game did not
  have FM sound effects.

### Todo

Add support for PSG and OPN LFO.

Decompile all music from the arcade version to make editing easier.

### Copyright

This program is written by ctr.

Dragon Spirit sound data is copyright Bandai Namco Entertainment and used
without permission. (Please don't sue me)
