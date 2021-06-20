# Music commands

## Track commands
- `JUMP <label>` - Jump to `<label>`
- `CALL <label>` - Call a subroutine at `<label>`
- `RET` - Return from subroutine, alternatively stop track.
- `END` - End track
- `REPT <count>,<label>`- Repeat section from `<label>`
- `LOOP <count>,<label>`- Jump to `label` when this command at the end of loop
- `TEMPO` - Set track tempo multiplier
- `SPEED` - Set track tempo
- `TVOL` - Set track volume
- `PCM <data>` - Request PCM sample. Not yet implemented.
- `COMM <data>` - used by sound test to identify speaker. Not used here
- `CH3 <flag> [<note>,<offset1>,<offset2>,<offset3>]` If flag is 0x40, enable
  Ch3 special mode and read extra parameters. Offsets correspond to OPM DT2
  values for operators 1-3.

## Channel commands
- `INIT` - Old initialization command.
- `CHANNEL` - New initialization commands. Parameter is channel number,
	1-6 for FM, 7-9 for PSG
- `VOL` - Channel volume
- `PAN` - Panning. Valid values `L__`, `_C_`, `__R`
- `DTN` - Detune
- `PIT` - Set pitch envelope number. 0 to disable
- `PITRAT` - Set pitch envelope rate
- `PITDEP` - Set pitch envelope depth
- `DEL` - Set delay. This value is reset after each note
- `GTM` - Set gate time
- `LFO` - Set LFO preset
- `LEG` - Set legato. This value is decreased after each note, and if non-zero,
	disables key-on / attack phase of envelope
- `LINK` - On PSG channel, read frequency for the CH2 pair from the specified
	channel.
- `LINKVOL` - Set attenuation for the CH2 pair.

## Row commands
- `FRQ` - Key on. Valid note values `Cn1, Cs1, Dn1` etc. `Q__` for key off

# Editing music data
## Notepad++
Use Alt+select to use multiple cursors. (IIRC you need to enable a
config option first)

## Vim
Use visual block mode (ctrl+v)
	Select the first block: ctrl-v move "ay
	Select the second block: ctrl-v move c ctrl-o "aP <Esc>
	(Handy for editing tracks)
