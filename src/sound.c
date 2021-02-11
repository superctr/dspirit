//=====================================================================
// Dragon Spirit Sound Driver (Based on QuattroPlay)
//
// Written by ctr
//=====================================================================

#include <genesis.h>
#include <kdebug.h>
#include "sdata.h"
#include "sound.h"

static void snd_kill_channel(struct snd_channel *channel);
static inline void snd_update_track(struct snd_track *track);

void snd_init()
{
	Z80_init();
	Z80_loadDriver(Z80_DRIVER_2ADPCM,1);
	memset(&snd_bgm, 0, sizeof(snd_bgm));
}

void snd_request_bgm(u8 id)
{
	snd_bgm.request = id;
}

void snd_stop_bgm()
{
	snd_bgm.request = 0xff;
}

void snd_request_se(u8 id)
{
}

void snd_stop_se()
{
}

void snd_update()
{
	snd_update_track(&snd_bgm);

}

//=====================================================================
// STATIC STUFF
//=====================================================================

static u8 snd_track_vol;
static u8 snd_break;

static inline const u8* get_u8(u16 pos)
{
	return &dsmusic[pos];
}
static inline u8 read_u8(u16 pos)
{
	return dsmusic[pos];
}
static inline u16 read_u16(u16 pos)
{
	return (dsmusic[pos]<<8)|dsmusic[pos+1];
}

static inline void take_z80()
{
	Z80_requestBus(1);
}

static inline void release_z80()
{
	while (YM2612_read(0) & 0x80);
	YM2612_write(0, 0x2a);
	Z80_releaseBus();
}

//=====================================================================
// PITCH ENVELOPE
//=====================================================================
static inline void snd_set_peg(struct snd_channel* ch)
{
	ch->peg_loop = ch->peg_ptr = get_u8(read_u16(read_u16(6) + (ch->peg << 1)));
	ch->peg_counter = 0;
}

static inline void snd_set_peg_mod(struct snd_channel* ch)
{
	u8 depth = ch->peg_depth;
	s16 val = (ch->peg_value - 0x6400) >> 1;
	s32 mod = (val * depth) >> 8;
	ch->peg_mod = mod & 0xffff;
}

static void snd_update_peg(struct snd_channel* ch)
{
	if(!ch->peg)
		return;
	u16 counter = ch->peg_counter + ch->peg_rate;

	if(counter > 0xff)
		ch->peg_ptr++;

	u8 data = ch->peg_ptr[0];
	u8 target = ch->peg_ptr[1];

	if(target == 0xfd)
	{
		ch->peg ++;
		snd_set_peg(ch);
		ch->peg_counter = 0;
		return;
	}
	else if(target == 0xfe)
	{
		ch->peg_ptr = ch->peg_loop;
		ch->peg_counter = 0;
		return;
	}
	else if(target > 0xf0)
	{
		ch->peg = 0;
		ch->peg_value = data << 8;
		return snd_set_peg_mod(ch);
	}

	counter &= 0xff;
	ch->peg_counter = counter;

	u16 step = (target - data) * counter;
	ch->peg_value = (data << 8) + step;
	return snd_set_peg_mod(ch);
}

//=====================================================================
// FM SOUND UPDATE
//=====================================================================
static inline void snd_write_safe(struct snd_channel* ch, u8 reg, u8 data)
{
	while (YM2612_read(0) & 0x80);
	YM2612_writeReg(ch->fm.part, reg + ch->fm.offset, data);
}

static inline void snd_write(struct snd_channel* ch, u8 reg, u8 data)
{
	YM2612_writeReg(ch->fm.part, reg + ch->fm.offset, data);
}

static inline void snd_write_key(struct snd_channel* ch, u8 mask)
{
	take_z80();
	YM2612_writeReg(0, 0x28, (mask << 4) | (ch->fm.part << 2) | ch->fm.offset);
	release_z80();
}

static inline void snd_fm_set_volume(struct snd_channel* ch)
{
	if(~ch->flag & SND_FLAG_PATCH)
		return;
	for(int i = 0; i <= ch->fm.carrier; i++)
	{
		u16 d = ~(((ch->fm.patch_ptr[0x0b - i] & 0x7f) ^ 0x7f) * ch->volume) >> 8;
		ch->fm.tl[i] = d & 0x7f;
	}
}

static inline void snd_fm_set_patch(struct snd_channel* ch)
{
	static const u8 fm_con[8] = {0, 0, 0, 0, 1, 2, 2, 3};

	snd_write_key(ch, 0);
	take_z80();
	const u8* ptr = get_u8(read_u16(8) + ch->patch * 32);

	for(int i = 0; i < 4; i++)
		snd_write_safe(ch, 0x80, 0xff);

	ch->fm.patch_ptr = ptr;
	ch->flag |= SND_FLAG_PATCH;
	ch->fm.carrier = fm_con[ptr[0] & 7];
	ch->fm.patch_lfo = ((ptr[3] & 0x70) >> 4) | ((ptr[3] & 3) << 4);
	ch->pan_lfo = 0xc0;

	snd_write(ch, 0xb4, 0x00);
	snd_write(ch, 0xb0, ptr[0] & 0x3f);

	ptr += 4;
	for(int i = 0; i < 24*4; i += 4)
		snd_write_safe(ch, 0x30 + i, *ptr++);

	for(int i = 0; i <= ch->fm.carrier; i++)
		snd_write_safe(ch, 0x4c - (i << 2), 0x7f);

	snd_write_safe(ch, 0xb4, ch->pan_lfo);
	release_z80();

	snd_fm_set_volume(ch);
}

static inline void snd_fm_write_volume(struct snd_channel* ch)
{
	take_z80();
	for(int i = 0; i <= ch->fm.carrier; i++)
	{
		snd_write_safe(ch, 0x4c - (i << 2), ch->fm.tl[i]);
	}
	release_z80();
}

static inline void snd_fm_set_lfo(struct snd_channel* ch)
{
	//TODO:LFO
}

static inline void snd_fm_update_reset(struct snd_channel* ch)
{
	if((~ch->flag & SND_FLAG_KEYON) || ch->delay)
		return;
	ch->peg = ch->peg_set;
	if(ch->peg)
	{
		ch->peg_depth = ch->peg_depth_set;
		ch->peg_rate = ch->peg_rate_set;
		snd_set_peg(ch);
	}
	ch->peg_mod = 0;

	if(ch->lfo)
	{
		//TODO:LFO
	}

	snd_fm_write_volume(ch);
}

static inline void snd_fm_update_gate(struct snd_channel* ch)
{
	if(ch->gate_time && !(--ch->gate_time))
		return snd_write_key(ch, 0x00);
}

static inline void snd_fm_update_lfo(struct snd_channel* ch)
{
}

static inline void snd_fm_update_pitch(struct snd_channel* ch)
{
	static const u16 fnum[13] = {644, 681, 722, 765, 810, 858, 910, 964, 1021, 1081, 1146, 1214, 1288};
	union
	{
		u16 pitch;
		struct
		{
			u8 note;
			u8 frac;
		};
	} p;
	u8 octave;
	const u16* base;

	p.note = ch->transpose;
	p.frac = ch->detune;
	p.pitch += ch->pitch + ch->peg_mod;

	if(p.pitch != ch->last_pitch)
	{
		ch->last_pitch = p.pitch;

		octave = p.note / 12;
		base = &fnum[p.note % 12];

		p.pitch = base[0] + (((base[1] - base[0]) * p.frac) >> 8) + ((octave & 7) << 11);

		take_z80();
		snd_write_safe(ch, 0xa4, p.note);
		snd_write_safe(ch, 0xa0, p.frac);
		release_z80();
	}
}

static inline void snd_fm_update(struct snd_channel* ch)
{
	snd_fm_update_gate(ch);
	snd_fm_update_reset(ch);
	snd_fm_update_lfo(ch);
	snd_update_peg(ch);
	snd_fm_update_pitch(ch);

	if(ch->flag & SND_FLAG_KEYON)
	{
		if(ch->delay)
		{
			ch->delay--;
		}
		else
		{
			snd_write_key(ch, 15);
			ch->gate_time = ch->gate_time_set;
			ch->flag &= ~(SND_FLAG_KEYON);
		}
	}
}


//=====================================================================
// SOUND INIT/KILL
//=====================================================================

void snd_init_channels(struct snd_track* trk, u8 mask)
{
	struct snd_channel *ch = &trk->channels[0];
	u8 fm_channels = 6;
	u8 part = 0;
	u8 offset = 0;

	while(mask)
	{
		if(mask & 0x80 && fm_channels)
		{
			//KDebug_Alert("Initializing channel");
			//KDebug_AlertNumber(part);
			//KDebug_AlertNumber(offset);
			ch->mode = SND_MODE_FM;
			ch->fm.part = part;
			ch->fm.offset = offset++;

			if(offset == 3)
			{
				part++;
				offset = 0;
			}
			fm_channels--;

			ch->flag = SND_FLAG_FG;
			ch->frac = 0;
		}
		mask <<= 1;
		ch++;
	}
}

static void snd_kill_channel(struct snd_channel* ch)
{
	if(ch->mode == SND_MODE_FM)
	{
		//KDebug_Alert("Killing channel");
		//KDebug_AlertNumber(ch->fm.part);
		//KDebug_AlertNumber(ch->fm.offset);
		snd_write_key(ch, 0);
		take_z80();
		snd_write_safe(ch, 0x40, 127);
		snd_write_safe(ch, 0x44, 127);
		snd_write_safe(ch, 0x48, 127);
		snd_write_safe(ch, 0x4c, 127);
		release_z80();
	}
	ch->mode = SND_MODE_DISABLED;
	memset(ch, 0, sizeof(*ch));
}

//=====================================================================
// SOUND COMMAND
//=====================================================================

static inline u8 arg8(struct snd_track* trk)
{
	return read_u8(trk->position++);
}

static inline u16 arg16(struct snd_track* trk)
{
	u16 ret;
	ret = read_u8(trk->position++) << 8;
	ret |= read_u8(trk->position++);
	return ret;
}

void snd_cmd_nop(struct snd_track* trk, u8 length)
{
	trk->position += length - 1;
}

void snd_cmd_track_vol(struct snd_track* trk, u8 length)
{
	trk->volume = snd_track_vol = arg8(trk);
}

void snd_cmd_tempo_base(struct snd_track* trk, u8 length)
{
	trk->base_tempo = arg8(trk);
}

void snd_cmd_tempo(struct snd_track* trk, u8 length)
{
	trk->tempo = arg8(trk);
}

void snd_cmd_jump(struct snd_track* trk, u8 length)
{
	trk->position = arg16(trk);
}

void snd_cmd_pat(struct snd_track* trk, u8 length)
{
	u16 dest = arg16(trk);
	trk->sub_stack[trk->sub_stack_pos++] = trk->position;
	trk->position = dest;
}

void snd_cmd_return(struct snd_track* trk, u8 length)
{
	if(trk->sub_stack_pos)
	{
		trk->position = trk->sub_stack[--trk->sub_stack_pos];
	}
	else
	{
		snd_break = 1;
		trk->current_id = 0;
		for(int ch = 0; ch < 8; ch ++)
			snd_kill_channel(&trk->channels[ch]);
	}
}

void snd_cmd_repeat(struct snd_track* trk, u8 length)
{
	u8 repeat_count = arg8(trk);
	u16 repeat_dest = arg16(trk);
	u8 sp = trk->repeat_stack_pos;

	if(trk->repeat_stack[sp - 1] == trk->position)
	{
		sp--;
		if(--trk->repeat_count[sp] != 0)
			trk->position = repeat_dest;
		else
			trk->repeat_stack_pos = sp;
	}
	else
	{
		trk->repeat_stack[sp] = trk->position;
		trk->repeat_count[sp] = repeat_count;
		trk->repeat_stack_pos ++;
		trk->position = repeat_dest;
	}
}

void snd_cmd_loop(struct snd_track* trk, u8 length)
{
	u8 loop_count = arg8(trk);
	u16 loop_dest = arg16(trk);
	u8 sp = trk->loop_stack_pos;

	if(trk->loop_stack[sp - 1] == trk->position)
	{
		sp--;
		if(--trk->loop_count[sp] == 0)
		{
			trk->position = loop_dest;
			trk->loop_stack_pos = sp;
		}
	}
	else
	{
		trk->loop_stack[sp] = trk->position;
		trk->loop_count[sp] = loop_count;
		trk->loop_stack_pos ++;
	}
}

void snd_cmd_init(struct snd_track* trk, u8 length)
{
	u8 mask = arg8(trk);
	snd_init_channels(trk,mask);
}

//=====================================================================

void snd_cmd_nop_ch(struct snd_channel* ch, u8 arg)
{
}

void snd_cmd_key_on(struct snd_channel* ch, u8 arg)
{
	if(arg == 0xff)
	{
		if(ch->flag & SND_FLAG_FG && ch->mode == SND_MODE_FM)
			snd_write_key(ch, 0); // TODO:PSG
	}
	else
	{
		if(ch->flag & SND_FLAG_FG && ch->mode == SND_MODE_FM)
		{
			if(!ch->legato)
				snd_write_key(ch, 0);
			else
				ch->legato--;
			ch->flag |= SND_FLAG_KEYON;
		}
		else
		{
			if(ch->legato)
				ch->legato--;
		}
		ch->note = arg;
	}
}

void snd_cmd_patch(struct snd_channel* ch, u8 arg)
{
	ch->patch = arg;
	if(ch->flag & SND_FLAG_FG && ch->mode == SND_MODE_FM)
		snd_fm_set_patch(ch); // TODO:PSG
}

void snd_cmd_volume(struct snd_channel* ch, u8 arg)
{
	ch->volume = (arg * snd_track_vol) >> 8;
	if(ch->flag & SND_FLAG_FG && ch->mode == SND_MODE_FM)
		snd_fm_set_volume(ch); // TODO:PSG
}

void snd_cmd_transpose(struct snd_channel* ch, u8 arg)
{
	ch->transpose = arg;
}

void snd_cmd_detune(struct snd_channel* ch, u8 arg)
{
	ch->detune = arg;
}

void snd_cmd_peg(struct snd_channel* ch, u8 arg)
{
	ch->peg_set = arg;
}

void snd_cmd_peg_rate(struct snd_channel* ch, u8 arg)
{
	ch->peg_rate_set = arg;
}

void snd_cmd_peg_depth(struct snd_channel* ch, u8 arg)
{
	ch->peg_depth_set = arg;
}

void snd_cmd_legato(struct snd_channel* ch, u8 arg)
{
	ch->legato = arg;
}

void snd_cmd_gate_time(struct snd_channel* ch, u8 arg)
{
	ch->gate_time_set = arg;
}

void snd_cmd_delay(struct snd_channel* ch, u8 arg)
{
//	ch->delay_set = arg;
	ch->delay = arg;
}

void snd_cmd_lfo(struct snd_channel* ch, u8 arg)
{
	ch->lfo = arg;
}

void snd_cmd_pan(struct snd_channel* ch, u8 arg)
{
	ch->pan_lfo = (ch->pan_lfo & 0x3f) | (arg & 0xc0);
	if(ch->flag & SND_FLAG_FG && ch->mode == SND_MODE_FM)
	{
		take_z80();
		snd_write_safe(ch, 0xb4, ch->pan_lfo);
		release_z80();
	}
}

static const struct snd_cmd snd_cmd_table[34] =
{
/* 00 */ {1,0,snd_cmd_nop},
/* 01 */ {2,0,snd_cmd_track_vol},
/* 02 */ {2,0,snd_cmd_tempo_base},
/* 03 */ {2,0,snd_cmd_tempo},
/* 04 */ {3,0,snd_cmd_pat},
/* 05 */ {1,0,snd_cmd_return},
/* 06 */ {0,1,snd_cmd_key_on},
/* 07 */ {0,0,snd_cmd_patch},
/* 08 */ {0,0,snd_cmd_volume},
/* 09 */ {3,0,snd_cmd_jump},
/* 0a */ {1,1,snd_cmd_return}, //???
/* 0b */ {3,0,snd_cmd_repeat},
/* 0c */ {3,0,snd_cmd_loop},
/* 0d */ {0,0,snd_cmd_transpose},
/* 0e */ {0,0,snd_cmd_detune},
/* 0f */ {0,0,snd_cmd_peg},
/* 10 */ {0,0,snd_cmd_peg_rate},
/* 11 */ {0,0,snd_cmd_legato},
/* 12 */ {0,0,snd_cmd_gate_time},
/* 13 */ {0,0,snd_cmd_peg_depth},
/* 14 */ {0,0,snd_cmd_nop_ch}, // TODO: volume env
/* 15 */ {0,0,snd_cmd_delay},
/* 16 */ {0,0,snd_cmd_nop_ch}, // TODO: WSG request
/* 17 */ {0,0,snd_cmd_nop_ch}, // TODO: DAC request
/* 18 */ {0,0,snd_cmd_lfo}, // lfo
/* 19 */ {0,0,snd_cmd_pan}, // pan
/* 1a */ {0,0,snd_cmd_nop_ch}, // TODO: instrument flag ? (dspirit x68k)
/* 1b */ {2,0,snd_cmd_nop}, // communication byte
/* 1c */ {2,0,snd_cmd_nop}, // shadowld song 0e: song request
/* 1d */ {3,0,snd_cmd_nop}, // TODO:request track
/* 1e */ {3,0,snd_cmd_nop}, // TODO: request track
/* 1f */ {1,1,snd_cmd_nop}, // ctr: Empty row
/* 20 */ {2,0,snd_cmd_init},
/* 21 */ {2,0,snd_cmd_nop}, // TODO: ADPCM request
};

//=====================================================================
// COMMAND UPDATE
//=====================================================================
static void snd_read_command(struct snd_track* trk)
{
	snd_break = 0;
	while(!snd_break)
	{
		u8 cmd_byte = arg8(trk);
		u8 cmd_type = cmd_byte & 0x3f;
		if(cmd_type < 0x22)
		{
			//KDebug_Alert("Reading command");
			//KDebug_AlertNumber(trk->position);
			//KDebug_AlertNumber(cmd_byte);
			const struct snd_cmd* cmd_def = &snd_cmd_table[cmd_type];
			snd_break = cmd_def->row_break;
			if(cmd_def->length == 0)
			{
				struct snd_channel* ch = &trk->channels[0];
				snd_vcmd_ptr_t cmd_ptr = cmd_def->cmd_ptr;
				u8 mask = arg8(trk);
				if(cmd_byte & 0x40)
				{
					u8 val = arg8(trk);
					while(mask)
					{
						if(mask & 0x80)
							cmd_ptr(ch, val);
						ch++;
						mask <<= 1;
					}
				}
				else
				{
					while(mask)
					{
						if(mask & 0x80)
						{
							//KDebug_AlertNumber(ch);
							cmd_ptr(ch, arg8(trk));
						}
						ch++;
						mask <<= 1;
					}
				}
			}
			else
			{
				snd_tcmd_ptr_t cmd_ptr = cmd_def->cmd_ptr;
				cmd_ptr(trk, cmd_def->length);
			}
		}
		else
		{
			KDebug_Alert("Invalid sequence command");
			KDebug_AlertNumber(trk->position);
			KDebug_AlertNumber(cmd_byte);
			SYS_die("Invalid sequence command");
		}
	}
}

//=====================================================================
// TRACK UPDATE
//=====================================================================
static inline void snd_update_track(struct snd_track* trk)
{
	if(trk->request)
	{
		for(int ch = 0; ch < 8; ch ++)
			snd_kill_channel(&trk->channels[ch]);

		if(trk->request == 0xff)
		{
			// stop request
			trk->current_id = 0;
		}
		else
		{
			trk->update_time = 1;
			trk->base_tempo = 1;
			trk->tempo = 6;
			trk->position = read_u16(read_u16(0) + (trk->request << 1));
			trk->volume = 255;
			trk->sub_stack_pos = 0;
			trk->repeat_stack_pos = 0;
			trk->loop_stack_pos = 0;
			trk->current_id = trk->request + 1;
			//KDebug_Alert("Starting BGM track");
			//KDebug_AlertNumber(trk->position);
			take_z80();
			YM2612_writeReg(0, 0x2b, 0x00);
			release_z80();
			// default initialization (song 08)
			if(read_u8(trk->position) != 0x20)
				snd_init_channels(trk, 0xff);
		}
		trk->request = 0;
	}

	if(trk->current_id)
	{
		snd_track_vol = trk->volume;

		trk->update_time--;
		if(trk->update_time == 0)
		{
			snd_read_command(trk);
			trk->update_time = trk->base_tempo * trk->tempo;
		}

		struct snd_channel* ch = &trk->channels[0];
		while(ch < &trk->channels[8])
		{
			if(~ch->flag & 0x80)
				return;
			switch(ch->mode)
			{
				case SND_MODE_DISABLED:
					break;
				case SND_MODE_FM:
					snd_fm_update(ch);
					break;
			}
			ch++;
		}
	}
}

